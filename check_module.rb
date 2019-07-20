# @todo
def check_player
  player = list_the_collection(Player.all(order: :id))
  achievement = list_the_collection(Achievement.all(order: :id))
  if achievement.countable
    puts 'Enter the value to check'
    value = gets.chomp.to_i
  end

  achievement_query = PlayerStatistic.all(achievement: achievement,
                                          player: player, achieved: true,
                                          :value.gte => value)

  if achievement_query.empty?
    puts "#{player.name} doesn't achieve this stats"
  else
    puts "#{player.name} achieved this stat for #{achievement_query.count} times"
  end
end