# @todo
def check_player
  stats = Achievement.all(order: @id)
  stats.each do |stat|
    puts stat.id + '. ' + stat.name
  end
end
