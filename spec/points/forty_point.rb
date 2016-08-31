class FortyPoint

  def player_1_scored opponent_score
    GameScore.finished Game, opponent_score
  end

  def player_2_scored opponent_score
    GameScore.finished opponent_score, Game
  end

end