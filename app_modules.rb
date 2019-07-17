require './models'

def fill_database
  puts 'Choose the option:'
  puts '1. Enter new conference'
  puts '2. Enter new division'
  puts '3. Enter new position'
  puts '4. Enter new team'
  puts '5. Enter new player'
  puts '6. Enter new achievement'
  puts '7. Enter new match'
  puts '8. Return ot main menu'
  insert_data = gets.chomp.to_i
  filling_case(insert_data)
end

# @todo
def check_player
  stats = Achievement.all(order: @id)
  stats.each do |stat|
    puts stat.id + '. ' + stat.name
  end
end

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
    enter_new_position
  when 4
    enter_new_team
  when 5
    enter_new_player
  when 6
    enter_new_achievement
  when 7
    enter_new_match
  when 8
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

def enter_new_division
  puts 'Enter the name of division'
  Division.new.register(gets.chomp)
end

def enter_new_position
  puts 'Enter the name of position'
  Position.new.register(gets.chomp)
end

def enter_new_team
  puts 'Enter the name of team'
  name = gets.chomp

  puts 'Enter full name of its coach'
  coach = gets.chomp

  conferences = Conference.all(order: @id)
  puts 'Which conference this team belong:'
  conference = Conference.get(list_the_collection(conferences))

  divisions = Division.all(order: @id)
  puts 'Which division this team belongs:'
  division = divisions.get(list_the_collection(divisions))

  Team.new.register(name, coach, conference, division)
end

def enter_new_player
  puts 'Enter full name of player'
  name = gets.chomp

  puts 'Enter age of the player'
  age = gets.chomp

  puts 'Enter the number of the player'
  number = gets.chomp

  positions = Position.all(order: @id)
  puts 'On which position he plays:'
  position = positions.get(list_the_collection(positions))

  puts 'Enter the name of team that he plays'
  team = gets.chomp
  Team.

  Player.new.register(name, age, position, number, team + '*')
end

def list_the_collection(collection)
  collection.each do |col|
    puts col.id.to_s + '. ' + col.name
  end
  i = true
  while i
    collection_id = gets.chomp.to_i
    i = false
    unless (1..collection[-1].id).cover?(collection_id)
      puts 'You put wrong option. Please try again'
      i = true
    end
  end
  collection_id
end