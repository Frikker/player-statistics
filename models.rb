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
    @team = Team.create(name: name, coach_name: couch, conference: conference,
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
  property :number,     Integer

  has Infinity, :achievements

  belongs_to :team
  belongs_to :position

  def register(name, age, position, number, team)
    @player = Player.create(name: name, age: age, position: position,
                            number: number, team: Team.get(team: team))
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

class Position
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has Infinity, :players

  def register(name)
    @position = Position.create(name: name)
    @position.save
  end
end
