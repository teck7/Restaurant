require 'artii'
require 'terminal-table'

class MenuItem
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end

class Order
  def initialize()
    @items = []
  end

  def << (menu_item)
    @items << menu_item
  end

  def total
    total = 0
    @items.each do |item|
      total += item.price
    end
    "$#{total}"
  end

  def bill
    table = Terminal::Table.new headings: ['Name', 'Price'] do |t|
      @items.each do |item|
        t << [item.name, "$#{item.price}"]
      end
      t.add_separator
      t << ['TOTAL', total]
    end
    table
  end
end

###############################################################
#Table Serving Start up
a = Artii::Base.new :font => 'banner'
puts a.asciify('Restaurant')
###############################################################

MENU_ITEMS = [
  MenuItem.new('Steak', 20),
  MenuItem.new('Parma', 15),
  MenuItem.new('Eggplant Casserole', 15),
  MenuItem.new('Chips', 7),
  MenuItem.new('Beer', 7),
  MenuItem.new('Soft drink', 3.50)
]

puts "Welcome to the restaurant, please have a look at our main menu"

# Show menu
def display_menu
  rows = []
  # Headings
  table = Terminal::Table.new :title => "Main Menu", :rows => rows
  table << ["Index", "Food & Drinks", {:value => "($) Price", :alignment => :center}]
  table << :separator
  MENU_ITEMS.each_with_index do |menu_item, index|
    user_index = index + 1
    # Display item with index first, then name and price
    table << ["#{user_index}", "#{menu_item.name}", {:value => "#{menu_item.price}", :alignment => :center}]
  end
  table.style = {:border_x => "=", :border_i => "x"}
  puts table
  puts
  puts "Press any key return to main application"
  choice = gets
  return main([]) if choice

end

# Add menu items
def order_items
  rows = []
  # Headings
  table = Terminal::Table.new :title => "Order Now from Main Menu", :rows => rows
  table << ["Index", "Food & Drinks", {:value => "($) Price", :alignment => :center}]
  table << :separator
  MENU_ITEMS.each_with_index do |menu_item, index|
    user_index = index + 1
    # Display item with index first, then name and price
    table << ["#{user_index}", "#{menu_item.name}", {:value => "#{menu_item.price}", :alignment => :center}]
  end

  puts table

  order = Order.new

  loop do
    puts 'What would you like?'
    choice = gets.chomp
    # User must choose an index number
    user_index = choice.to_i
    # Stop looping if user pressed just enter
    break if choice == ""
    # If the user entered in an invalid choice
    # Set a range
    if user_index < 1 || user_index > 6
      puts "Invalid choice, please try again"
      next # Loop through and ask again
    end
    puts "Let me repeat the orders again!"
    puts "You have ordered #{MENU_ITEMS[choice.to_i - 1].name}"


    index = user_index - 1 # Convert to zero-based index
    menu_item = MENU_ITEMS[index]

    # Add item to order
  order << menu_item
  end
  return main(order)
end


def req_bill(order)
  system 'clear'
  puts order.bill
  sleep 2
end


def main(order)
  system 'clear'
  loop do
    puts 'Pick an option'
    puts '1. Show Menu'
    puts '2. Order Food'
    puts '3. Request Bill'
    puts '4. Exit Now'
    choice = gets.chomp
    case choice
        when '1'
          system 'clear'
          display_menu
        when '2'
          system 'clear'
          order_items
        when '3'
          system 'clear'
          req_bill(order)
        when '4'
          exit
        else
          puts "Invalid choice: #{choice}"
      end

      sleep 1
  end
end
order = []
main(order)
