class FifteenPoint < Point

  def player_1_scored opponent_score
    GameScore.non_finished Point.thirty, opponent_score
  end

  def player_2_scored opponent_score
    GameScore.non_finished opponent_score, Point.thirty
  end

end