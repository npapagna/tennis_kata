class AdvantagePlayer2GameScore < GameScore

  def player_1_scored
    GameScore.deuce
  end

  def player_2_scored
    GameScore.non_finished Forty, Game
  end

end