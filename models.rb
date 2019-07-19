# table Team that keep information about all of teams of the league
class Team
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String

  has Infinity, :team_matches
  has Infinity, :players

  def register(name)
    @team = Team.create(name: name)
    @team.save
  end
end

# table Player, that keep information about players of all teams
class Player
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String

  belongs_to :team
  belongs_to :position

  has Infinity, :player_statistics

  def register(name, position, team)
    @player = Player.create(name: name, position: position,
                            team: team)
    @player.save
  end
end

# table Achievements with any possible achievements for player
class Achievement
  include DataMapper::Resource

  property :id,       Serial
  property :name,     String
  property :countable, Boolean

  has Infinity, :player_statistics

  def register(name, countable)
    @achievement = Achievement.create(name: name, countable: countable)
    @achievement.save
  end
end

# table Match with information about opponent and date of team's match
class TeamMatch
  include DataMapper::Resource

  property :id, Serial
  property :opponent, Integer
  property :date, Date
  property :name, String

  has Infinity, :player_statistics

  belongs_to :team

  def register(team, opponent, date = Date.today)
    name = "#{team.name} vs. #{Team.get(opponent).name}. date"
    @match = TeamMatch.create(name: name, opponent: opponent, date: date, team: team)
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

class PlayerStatistic
  include DataMapper::Resource

  property :id, Serial
  property :value, Integer
  property :achieved, Boolean

  belongs_to :player
  belongs_to :team_match
  belongs_to :achievement

  def register(player, team_match, achievement, count, achieved = true)
    @player_statistic = PlayerStatistic.create(player: player, team_match: team_match,
                                               achievement: achievement, value: count,
                                               achieved: achieved)
    @player_statistic.save
  end
end