class AdvantagePlayer2GameScore < GameScore

  def player_1_scored
    GameScore.deuce
  end

  def player_2_scored
    GameScore.non_finished Point.forty, Point.game
  end

end