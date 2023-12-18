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
    puts ' Method: create_item'
  when 2
    puts ' Method: archive_item'
  when 3
    puts ' Method: list_all_items'
  when 4
    puts 'Thank you for using this app!'
    exit
  else
    puts 'Invalid option'
  end
end

main
