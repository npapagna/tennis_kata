class NonFinishedGameScore < GameScore

  def initialize a=Love, b=Love
    @player_1_score = a
    @player_2_score = b
  end

  def player_1_points
    @player_1_score
  end

  def player_2_points
    @player_2_score
  end

  def player_1_scored
    @player_1_score.player_1_scored @player_2_score
  end

  def player_2_scored
    @player_2_score.player_2_scored @player_1_score
  end

end