# require_relative 'item'

def main
  puts 'Welcome to the Catalog of my Personal Things'
  loop do
    puts '1) Add new item'
    puts '2) Archive item'
    puts '3) List all items'
    puts '4) Exit the app'
    gets_option
  end
end

def gets_option
  print 'Enter your option here: '
  option = gets.chomp.to_i
  case option
  when 1
    create_item
  when 2
    archive_item
  when 3
    list_all_items
  when 4
    puts 'Thank you for using this app!'
    exit
  else
    puts 'Invalid option'
  end
end

# Placeholder for the create_item method
def create_item
  puts 'Creating a new item...'
  # Implementation for creating a new item goes here
end

# Placeholder for the archive_item method
def archive_item
  puts 'Archiving an item...'
  # Implementation for archiving an item goes here
end

# Placeholder for the list_all_items method
def list_all_items
  puts 'Listing all items...'
  # Implementation for listing all items goes here
end
main