class LovePoint

  def player_1_scored opponent_score
    GameScore.non_finished Fifteen, opponent_score
  end

  def player_2_scored opponent_score
    GameScore.non_finished opponent_score, Fifteen
  end

end