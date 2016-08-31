class Point

  def self.love
    @love ||= LovePoint.new
  end

  def self.fifteen
    @fifteen ||= FifteenPoint.new
  end

  def self.thirty
    @thirty ||= ThirtyPoint.new
  end

  def self.forty
    @forty ||= FortyPoint.new
  end

  def self.game
    @game ||= Object.new
  end

  def player_1_scored opponent_score
    self.subclass_responsibility
  end

  def player_2_scored opponent_score
    self.subclass_responsibility
  end

end

require_relative 'love_point'
require_relative 'fifteen_point'
require_relative 'thirty_point'
require_relative 'forty_point'