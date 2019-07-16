require 'rubygems'
require 'data_mapper'

# Main module of console application for
DataMapper.setup(:default, 'sqlite::memory:')
DataMapper::Property::String.length(255)
DataMapper.auto_migrate!

class Conference
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  belongs_to :team

  def register(name)
    @match = Conference.create(name: name)
    @match.save
  end
end

class Division
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  belongs_to :team

  def register(name)
    @match = Division.create(name: name)
    @match.save
  end
end
# table Team that keep information about all of teams of the league
class Team
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String
  property :coach_name, String

  has Infinity, :teamsmatches
  has 1, :conferences
  has 1, :divisions

  belongs_to :player
  def register(name, couch, conference, division)
    @team = Team.create()
  end
end

# table Player, that keep information about players of all teams
class Player
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String
  property :age,        Integer
  property :height,     Float
  property :position,   String
  property :number,     Integer

  has Infinity, :achievements
  has 1, :teams
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
class TeamsMatch
  include DataMapper::Resource

  property :id, Serial
  property :opponent, Team
  property :date, Date

  belongs_to :team

  def register(opponent, date = Date.today)
    @match = Match.create(opponent: opponent, date: date)
    @match.save
  end
end

DataMapper.finalize