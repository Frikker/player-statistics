#!/usr/bin/ruby
require 'rubygems'
require 'data_mapper'
require 'sqlite3'
require './app_modules'

DataMapper.setup(:default, {
    adapter: 'sqlite3',
    database: 'identifier.sqlite',
    username: 'Frikker',
    password: 'Diving000',
})
DataMapper::Property::String.length(255)

DataMapper.finalize
DataMapper.auto_upgrade!

puts 'Hello! Choose the option and press "Enter"'

def main_menu(i)
  puts '1. Enter new information to DB'
  puts '2. Check information about player'
  puts '3. Check top-5 players in any achievement'
  puts '4. Exit'
  insert_data = gets.chomp.to_i
  case insert_data
  when 1
    fill_database
  when 2
    check_player
  when 3
    top_5
  when 4
    return false
  else
    puts 'You put wrong option. Please try again'
    main_menu(i)
  end
end

i = true
i = main_menu(true) while i
