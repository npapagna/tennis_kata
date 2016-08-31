class FifteenPoint
  def player_1_scored opponent_score
    GameScore.non_finished Thirty, opponent_score
  end
  def player_2_scored opponent_score
    GameScore.non_finished opponent_score, Thirty
  end
end