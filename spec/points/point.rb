class Point

  def self.love
    LovePoint.new
  end

  def self.fifteen
    FifteenPoint.new
  end

  def self.thirty
    ThirtyPoint.new
  end

  def self.forty
    FortyPoint.new
  end

  def self.game
    Object.new
  end

  def player_1_scored opponent_score
    self.subclass_responsibility
  end

  def player_2_scored opponent_score
    self.subclass_responsibility
  end

end