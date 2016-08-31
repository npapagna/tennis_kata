class FortyPoint < Point

  def player_1_scored opponent_score
    GameScore.finished Point.game, opponent_score
  end

  def player_2_scored opponent_score
    GameScore.finished opponent_score, Point.game
  end

end