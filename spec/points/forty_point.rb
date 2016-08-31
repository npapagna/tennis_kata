class FortyPoint < Point

  def player_1_scored opponent_score
    GameScore.player_1_won opponent_score
  end

  def player_2_scored opponent_score
    GameScore.player_2_won opponent_score
  end

end