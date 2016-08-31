class GameScore

  def self.non_finished player_points, opponent_points
    NonFinishedGameScore.new player_points, opponent_points
  end

  def self.finished player_points, opponent_points
    FinishedGameScore.new player_points, opponent_points
  end

  def player_1_points
    self.subclass_responsibility
  end

  def player_2_points
    self.subclass_responsibility
  end

  def player_1_scored
    self.subclass_responsibility
  end

  def player_2_scored
    self.subclass_responsibility
  end

end