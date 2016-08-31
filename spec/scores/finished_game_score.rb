class FinishedGameScore < GameScore

  attr_reader :player_1_points, :player_2_points

  def initialize player_1_score, player_2_score
    @player_1_points = player_1_score
    @player_2_points = player_2_score
  end

  def player_1_scored
    notify_game_is_over
  end

  def player_2_scored
    notify_game_is_over
  end

  def notify_game_is_over
    fail 'Game over'
  end

end