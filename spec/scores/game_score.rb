class GameScore

  def self.initial
    self.non_finished Point.love, Point.love
  end

  def self.deuce
    @deuce ||= DeuceGameScore.new
  end

  def self.advantage_player_1
    @advantage_player_1 ||= AdvantagePlayer1GameScore.new
  end

  def self.advantage_player_2
    @advantage_player_2 ||= AdvantagePlayer2GameScore.new
  end

  def self.non_finished player_points, opponent_points
    NonFinishedGameScore.new player_points, opponent_points
  end

  def self.finished player_points, opponent_points
    FinishedGameScore.new player_points, opponent_points
  end

  def self.player_1_won opponent_score
    self.finished Point.game, opponent_score
  end

  def self.player_2_won opponent_score
    self.finished opponent_score, Point.game
  end

  def player_1_points
    self.subclass_responsibility
  end

  def player_2_points
    self.subclass_responsibility
  end

  def player_1_scored
    self.subclass_responsibility
  end

  def player_2_scored
    self.subclass_responsibility
  end

end

require_relative 'finished_game_score'
require_relative 'non_finished_game_score'
require_relative 'deuce_game_score'
require_relative 'advantage_player1_game_score'
require_relative 'advantage_player2_game_score'