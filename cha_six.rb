require 'artii'
require 'terminal-table'

class MenuItem
  attr_accessor :name, :price, :description

  def initialize(name, price, description)
    @name = name
    @price = price
    @description = description
  end

end

#Additional Sub_Menus from Main
class Entree < MenuItem
end

class Main < MenuItem
end

class Dessert < MenuItem
end

class Drink < MenuItem
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
    @items = @items.flatten
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

ENTREE = [
  Entree.new('Spring Rolls', 6, 'Freshly made spring rolls'),
  Entree.new('Vege Dumplings', 5, 'Dumplings with super vege food')
]

MAIN = [
  Main.new('Fried Rice', 15, 'Seafood Fried Rice with Chilli'),
  Main.new('Fried Noodle', 12, 'Indonesia Mee Goreng')
]

DESSERT = [
  Dessert.new('Cake', 5, 'Cake of the day'),
  Dessert.new('Sweet Soup', 6, 'Sweet Potato with Ginger')
]

DRINK = [
  Drink.new('Brandy Spark', 8, 'Crafted beer and LimeSpark'),
  Drink.new('Lexy Eight', 6, 'Taasty Frenc'),
  Drink.new('Clasmintic', 4, 'Coll Hit'),
  Drink.new('Nescafe Lkil', 5, 'Miki Nes'),
  Drink.new('Harakily', 4, 'Cool Bite'),
  Drink.new('MalaiKai', 7, 'Hyjk Fool')
]

MENU_ITEMS = [
  ENTREE, MAIN, DESSERT, DRINK
]

def sub_menu_item(items)
  rows = []
  # Headings
  table = Terminal::Table.new :title => "Main Menu", :rows => rows
  table << ["Index", "Food & Drinks", "Description", {:value => "($) Price", :alignment => :center}]
  table << :separator
  items.each_with_index do |menu_item, index|
    user_index = index + 1
    # Display item with index first, then name and price
    table << ["#{user_index}", "#{menu_item.name}", "#{menu_item.description}", {:value => "#{menu_item.price}", :alignment => :center}]
  end
  table.style = {:border_x => "=", :border_i => "x"}
  puts table
end


def menu_choice
  menu_choice = gets.chomp
  system 'clear'
  case menu_choice
    when "1"
      sub_menu_item(ENTREE)
    when "2"
      sub_menu_item(MAIN)
    when "3"
      sub_menu_item(DESSERT)
    when "4"
      sub_menu_item(DRINK)
    when "5"
      main([])
  end
end

def sub_menu
  system 'clear'
  puts "Please choose from a sub menu"
  puts "1. Entree"
  puts "2. Mains"
  puts "3. Desserts"
  puts "4. Drinks"
  puts "5. Back to main application"

  menu_choice

  puts "press any key to return to previous menu"
  choice = gets
  return display_menu if choice
end

# Show menu
def display_menu
  sub_menu

  puts "press any key to go back to main menu"
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
  MENU_ITEMS.flatten.each_with_index do |menu_item, index|
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
    if user_index < 1 || user_index > 12
      puts "Invalid choice, please try again"
      next # Loop through and ask again
    end
    puts "Let me repeat the orders again!"
    puts "You ordered #{MENU_ITEMS.flatten[choice.to_i - 1].name}"

    puts 'Please tell us how do want your meal to be made'
    change = gets.chomp

    index = user_index - 1 # Convert to zero-based index
    menu_item = MENU_ITEMS.flatten[index]

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
    puts 'Please choose an option'
    puts '1. Show menu'
    puts '2. Order items'
    puts '3. Ask for bill'
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
