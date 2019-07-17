require './models'

def fill_database
  puts 'Choose the option:'
  puts '1. Enter new conference'
  puts '2. Enter new division'
  puts '3. Enter new team'
  puts '4. Enter new player'
  puts '5. Enter new achievement'
  puts '6. Enter new match'
  puts '7. Return ot main menu'
  insert_data = gets.chomp.to_i
  filling_case(insert_data)
end

# @todo
def check_player; end

# @todo
def top_5; end

#@todo
def filling_case(data)
  case data
  when 1
    enter_new_conference
  when 2
    enter_new_division
  when 3
    enter_new_team
  when 4
    enter_new_player
  when 5
    enter_new_achievement
  when 6
    enter_new_match
  when 7
    return
  else
    puts 'You put wrong option. Please try again'
    fill_database
  end
end

def enter_new_conference
  puts 'Enter the name of conference'
  Conference.new.register(gets.chomp)

end
