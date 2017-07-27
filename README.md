# Restaurant Ruby CLI Application
This is a Restaurant CLI application that allow users to view menus, order food & drinks, customise orders and pay bills.Coder This application was written to meet Coder Academy Exam requirements.

This file cha_seven.rb contain all reuqired codes for meeting all criteria and brief set out as followed;

---------------------------------------------------------------------------------------------------------
## Restaurant

### Skills

- Classes: `class`
- Instance variables: `@name`, `initialize`
- Constants: `MENU_ITEMS`
- Looping: `loop do`, `.each_with_index`
- Loop control: `next`, `break`
- Validation: `.to_i == 0`
- String interpolation: `"$#{price}"`
- Gems: `terminal-table`
- Delaying: `sleep`

### Demo

1. Define class for MenuItem
2. Define class for Order
3. Build menu items
4. Create new order
5. Display menu
6. Ask for user choice from menu, repeatedly
7. Validate the user’s choice, skipping if invalid
8. Add valid item to order
9. Delay output with `sleep`
10. Display order bill with total

### Challenge

Using the exist demo, add:

1. Separate the functionality into a main menu with:
    1. Show food menu
    2. Order items
    3. Ask for bill
2. When an item is ordered, repeat its name back to the user like a waiter would.
3. Choose from entree, main & desert submenus.
4. Add descriptions to items.
5. Add a drinks menu (with beers, wine, and cocktails). Research six cocktails to include.
6. Order with food options (e.g. no mushrooms please).
7. Allow payment of bill, either by cash or credit card.
    - Credit cards incur a surcharge of 1.5%. Display this as a line item on the bill, and include it in the total

---------------------------------------------------------------------------------------------------------------------------
