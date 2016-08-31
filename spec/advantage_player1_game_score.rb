class AdvantagePlayer1GameScore < GameScore

  def player_1_scored
    GameScore.non_finished Game, Forty
  end

  def player_2_scored
    GameScore.deuce
  end

end