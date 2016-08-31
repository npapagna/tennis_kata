class ThirtyPoint

  def player_1_scored opponent_score
    if opponent_score == Forty
      return GameScore.deuce
    end

    GameScore.non_finished Forty, opponent_score
  end

  def player_2_scored opponent_score
    if opponent_score == Forty
      return GameScore.deuce
    end
    GameScore.non_finished opponent_score, Forty
  end

end