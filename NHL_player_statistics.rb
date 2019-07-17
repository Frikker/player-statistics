require 'rubygems'
require 'data_mapper'
require 'sqlite3'

DataMapper.setup(:default, 'sqlite::memory:')
DataMapper::Property::String.length(255)

# table Conference
class Conference
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has Infinity, :teams

  def register(name)
    @conference = Conference.create(name: name)
    @conference.save
  end
end

# table Division
class Division
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has Infinity, :teams

  def register(name)
    @division = Division.create(name: name)
    @division.save
  end
end

# table Team that keep information about all of teams of the league
class Team
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String
  property :coach_name, String

  has Infinity, :team_matches
  has Infinity, :players

  belongs_to :conference
  belongs_to :division

  def register(name, couch, conference, division)
    @team = Team.create(name: name, couch_name: couch, conference: conference,
                        division: division)
    @team.save
  end
end

# table Player, that keep information about players of all teams
class Player
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String
  property :age,        Integer
  property :position,   String
  property :number,     Integer

  has Infinity, :achievements

  belongs_to :team

  def register(name, age, position, number, team)
    @player = Player.create(name: name, age: age, position: position,
                            number: number, team: Team.get(team))
    @player.save
  end
end

# table Achievements with any possible achievements for player
class Achievement
  include DataMapper::Resource

  property :id,       Serial
  property :name,     String
  property :achieved, Boolean, default: false

  belongs_to :player
end

# table Match with information about opponent and date of team's match
class TeamMatch
  include DataMapper::Resource

  property :id, Serial
  property :opponent, Team.class
  property :date, Date

  belongs_to :team

  def register(opponent, team, date = Date.today)
    @match = TeamMatch.create(opponent: opponent, date: date, team: team)
    @match.save
  end
end

DataMapper.finalize
DataMapper.auto_upgrade!

puts 'Hello! Choose the option and press "Enter"'

def main_menu
  puts '1. Enter new information to DB'
  puts '2. Check information about player'
  puts '3. Check top-5 players in any achievement'
end

main_menu
insert_data = gets.chomp

case insert_data
when 1
  fill_database
when 2
  check_player
when 3
  top_5
else
  puts 'You put wrong option. Please try again'
  main_menu
end
#@todo
def fill_database

end
#@todo
def check_player

end
#@todo
def top_5

end