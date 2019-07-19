# @todo
def check_player
  player = list_the_collection(Player.all(order: @id))
  achievements = list_the_collection(Achievement.all(order: @id))

  achievement_query = PlayerStatistic.all(achievement: achievements, player: player, achieved: true)

  if achievement_query.empty?
    puts "#{player.name} doesn't achieve this stats"
  else
    puts "#{player.name} achieved this stat for #{achievement_query.count} times" + pluralize
  end
end