class DeuceGameScore < GameScore

  def player_1_scored
    GameScore.advantage_player_1
  end

  def player_2_scored
    GameScore.advantage_player_2
  end

end