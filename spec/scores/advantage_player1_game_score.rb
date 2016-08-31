class AdvantagePlayer1GameScore < GameScore

  def player_1_scored
    GameScore.non_finished Point.game, Point.forty
  end

  def player_2_scored
    GameScore.deuce
  end

end