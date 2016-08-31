class GameScore

  def self.initial
    self.non_finished Point.love, Point.love
  end

  def self.deuce
    @deuce ||= DeuceGameScore.new
  end

  def self.advantage_player_1
    @advantage_player_1 ||= AdvantagePlayer1GameScore.new
  end

  def self.advantage_player_2
    @advantage_player_2 ||= AdvantagePlayer2GameScore.new
  end

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