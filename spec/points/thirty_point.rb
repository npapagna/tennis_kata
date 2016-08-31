class ThirtyPoint < Point

  def player_1_scored opponent_score
    if opponent_score == Point.forty
      return GameScore.deuce
    end

    GameScore.non_finished Point.forty, opponent_score
  end

  def player_2_scored opponent_score
    if opponent_score == Point.forty
      return GameScore.deuce
    end
    GameScore.non_finished opponent_score, Point.forty
  end

end