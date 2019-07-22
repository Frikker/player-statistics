require './models'

def fill_database
  puts 'Choose the option:'
  puts '1. Enter new team'
  puts '2. Enter new position'
  puts '3. Enter new player'
  puts '4. Enter new achievement'
  puts '5. Enter new match'
  puts '6. Return to main menu'
  insert_data = gets.chomp.to_i
  filling_case(insert_data)
end

def filling_case(data)
  case data
  when 1
    enter_new_team
  when 2
    enter_new_position
  when 3
    enter_new_player
  when 4
    enter_new_achievement
  when 5
    enter_new_match
  when 6
    return
  else
    puts 'You put wrong option. Please try again'
    fill_database
  end
end

def enter_new_position
  puts 'Enter the name of position'
  Position.new.register(check_input)
end

def enter_new_team
  puts 'Enter the name of team'
  Team.new.register(check_input)
end

def enter_new_player
  puts 'Enter full name of player'
  name = check_input
  position = list_the_collection(positions = Position.all(order: :id))
  team = list_the_collection(teams = Team.all(order: :id))
  Player.new.register(name, position, team)
end

def enter_new_achievement
  puts 'Enter the name of achievement'
  name = check_input
  puts 'Is it countable? (y/n)'
  Achievement.new.register(name, true_false_check)
end

def enter_new_match
  teams = Team.all(order: :id)
  first_team = list_the_collection(teams)

  puts 'Choose its opponent'
  second_team = list_the_collection(teams.all(:id.not => first_team)).id

  puts 'Enter date of match'
  date = check_input
  date = Date.parse date

  TeamMatch.new.register(first_team, second_team, date)
end

def enter_player_statistic
  team = list_the_collection(Team.all(order: :id))
  match = list_the_collection(TeamMatch.all(team: team, order: :id) +
                              TeamMatch.all(opponent: team.id))
  player = list_the_collection(Player.all(team: team, order: :id))
  achievement = list_the_collection(Achievement.all(order: :id))
  if achievement.countable
    puts 'Enter the Value'
    value = gets.chomp.to_i
    PlayerStatistic.new.register(player, match, achievement, value)
  else
    puts 'Did he achieve it: (y/n)'
    PlayerStatistic.new.register(player, match, achievement, 0, true_false_check)
  end
end

def list_the_collection(collection)
  puts "Select #{collection.name}"
  collection.each do |col|
    puts (collection.index(col) + 1).to_s + '. ' + col.name
  end
  i = true
  while i
    collection_id = gets.chomp.to_i
    i = false
    unless (1..(collection.index(collection[-1]) + 1)).cover?(collection_id)
      puts 'You put wrong option. Please try again'
      i = true
    end
  end
  collection[collection_id - 1]
end

def true_false_check
  i = true
  while i
    countable = gets.chomp.downcase
    i = false
    if countable == 'y'
      countable_achieve = true
    elsif countable == 'n'
      countable_achieve = false
    else
      puts 'You put wrong option. Please try again'
      i = true
    end
  end
  countable_achieve
end

def check_input
  input = gets.chomp
  if input.empty?
    puts 'You put wrong option. Please try again'
    check_input
  end
  input
end