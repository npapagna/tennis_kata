require 'spec_helper'
require_relative 'game_score'
require_relative 'finished_game_score'
require_relative 'non_finished_game_score'
require_relative 'deuce_game_score'
require_relative 'advantage_player1_game_score'
require_relative 'advantage_player2_game_score'

Game = Object.new

class FortyPoint
  def player_1_scored opponent_score
    GameScore.finished Game, opponent_score
  end
  def player_2_scored opponent_score
    GameScore.finished opponent_score, Game
  end
end

Forty = FortyPoint.new

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

Thirty = ThirtyPoint.new

class FifteenPoint
  def player_1_scored opponent_score
    GameScore.non_finished Thirty, opponent_score
  end
  def player_2_scored opponent_score
    GameScore.non_finished opponent_score, Thirty
  end
end

Fifteen = FifteenPoint.new

class LovePoint

  def player_1_scored opponent_score
    GameScore.non_finished Fifteen, opponent_score
  end

  def player_2_scored opponent_score
    GameScore.non_finished opponent_score, Fifteen
  end

end

Love = LovePoint.new

class TennisGame

  attr_reader :game_score

  def initialize
    @game_score = GameScore.non_finished Love, Love
    @player_1_serving = true
  end

  def win_point
    if @player_1_serving
      @game_score = @game_score.player_1_scored
    else
      @game_score = @game_score.player_2_scored
    end
  end

  def lose_point
    @player_1_serving = !@player_1_serving
  end

end

describe 'My behaviour' do

  let(:love) { Love }
  let(:fifteen) { Fifteen }
  let(:thirty) { Thirty }
  let(:forty) { Forty }
  let(:game) { Game }
  let(:deuce) { GameScore.deuce }
  let(:advantage_player_1) { GameScore.advantage_player_1 }
  let(:advantage_player_2)  {GameScore.advantage_player_2 }
  let(:tennis_game) { TennisGame.new }

  it '001' do
    assert_game_score_is love, love
  end

  it '002' do
    tennis_game.win_point

    assert_game_score_is fifteen, love
  end

  it '003' do
    tennis_game.win_point
    tennis_game.win_point

    assert_game_score_is thirty, love
  end

  it '004' do
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point

    assert_game_score_is forty, love
  end

  it '005' do
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point

    assert_game_score_is game, love
  end

  it '006' do
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point

    expect{ tennis_game.win_point }.to raise_error('Game over') do
      assert_game_score_is game, love
    end
  end

  it '007' do
    tennis_game.lose_point

    assert_game_score_is love, love
  end

  it '008' do
    tennis_game.lose_point
    tennis_game.win_point

    assert_game_score_is love, fifteen
  end

  it '009' do
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point

    assert_game_score_is love, thirty
  end

  it '010' do
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point

    assert_game_score_is love, forty
  end

  it '011' do
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point

    assert_game_score_is love, game
  end

  it '012' do
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point

    expect{ tennis_game.win_point }.to raise_error('Game over') do
      assert_game_score_is love, game
    end
  end

  it '012b' do
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.lose_point

    expect{ tennis_game.win_point }.to raise_error('Game over') do
      assert_game_score_is love, game
    end
  end

  it '013' do
    tennis_game.lose_point
    tennis_game.lose_point
    tennis_game.win_point

    assert_game_score_is fifteen, love
  end

  it '014' do
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point

    expect(tennis_game.game_score).to eq deuce
  end

  it '015' do
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point

    expect(tennis_game.game_score).to eq advantage_player_2
  end

  it '016' do
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point

    expect(tennis_game.game_score).to eq advantage_player_1
  end

  it '017' do
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point

    assert_game_score_is Forty, Game
  end

  it '018' do
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point

    assert_game_score_is Game, Forty
  end

  it '019' do
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.lose_point
    tennis_game.win_point

    expect(tennis_game.game_score).to eq deuce
  end

  it '020' do
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.lose_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.win_point
    tennis_game.lose_point
    tennis_game.win_point

    expect(tennis_game.game_score).to eq deuce
  end

  def assert_game_score_is player_1_score, player_2_score
    expect(tennis_game.game_score.player_1_points).to eq player_1_score
    expect(tennis_game.game_score.player_2_points).to eq player_2_score
  end

end