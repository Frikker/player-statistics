
# @todo
def top_5
  achievement = list_the_collection(Achievement.all(order: :id))
  puts 'Display information for team or for all league:'
  puts '1. Team'
  puts '2. League'
  check_statistic = gets.chomp.to_i
  statistics = PlayerStatistic.all(order: :value.desc)
  if check_statistic == 1
    team = list_the_collection(Team.all(order: :id))
    top_five_players = statistics.first(5,
                                        PlayerStatistic.player.team.name => team.name,
                                        achievement: achievement)
  elsif check_statistic == 2
    top_five_players = statistics.first(5, achievement: achievement)
  end

  top_five_players.each do |player|
    puts player.player.name + ': ' + player.value.to_s
  end
end