require 'spec_helper'

class DeucePoint

  def player_1_scored
    AdvantagePlayer1
  end

  def player_2_scored
    AdvantagePlayer2
  end

end

class AdvantagePlayer2

  def player_1_scored
    Deuce
  end

  def player_2_scored
    GameScore.new Forty, Game
  end

end

class AdvantagePlayer1

  def player_1_scored
    GameScore.new Game, Forty
  end

  def player_2_scored
    Deuce
  end

end

class GamePoint

  def player_1_scored opponent_score
    notify_game_is_over
  end

  def notify_game_is_over
    fail 'Game over'
  end

  def player_2_scored opponent_score
    notify_game_is_over
  end

end

Game = GamePoint.new

class FortyPoint
  def player_1_scored opponent_score
    GameScore.new Game, opponent_score
  end
  def player_2_scored opponent_score
    GameScore.new opponent_score, Game
  end
end

Forty = FortyPoint.new

class ThirtyPoint
  def player_1_scored opponent_score
    if opponent_score == Forty
      return Deuce
    end

    GameScore.new Forty, opponent_score
  end
  def player_2_scored opponent_score
    if opponent_score == Forty
      return Deuce
    end
    GameScore.new opponent_score, Forty
  end
end

Thirty = ThirtyPoint.new

class FifteenPoint
  def player_1_scored opponent_score
    GameScore.new Thirty, opponent_score
  end
  def player_2_scored opponent_score
    GameScore.new opponent_score, Thirty
  end
end

Fifteen = FifteenPoint.new

class LovePoint

  def player_1_scored opponent_score
    GameScore.new Fifteen, opponent_score
  end

   def player_2_scored opponent_score
    GameScore.new opponent_score, Fifteen
  end

end

Love = LovePoint.new


Deuce = DeucePoint.new
AdvantagePlayer1 = AdvantagePlayer1.new
AdvantagePlayer2 = AdvantagePlayer2.new

class GameScore

  def initialize a=Love, b=Love
    @player_1_score = a
    @player_2_score = b
  end

  def player_1
    @player_1_score
  end

  def player_2
    @player_2_score
  end

  def player_1_scored
    @player_1_score.player_1_scored @player_2_score
  end

  def player_2_scored
    @player_2_score.player_2_scored @player_1_score
  end

end

class TennisGame

  attr_reader :game_score

  def initialize
    @game_score = GameScore.new
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

    expect(tennis_game.game_score).to eq Deuce
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

    expect(tennis_game.game_score).to eq AdvantagePlayer2
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

    expect(tennis_game.game_score).to eq AdvantagePlayer1
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

    expect(tennis_game.game_score).to eq Deuce
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

    expect(tennis_game.game_score).to eq Deuce
  end

  def assert_game_score_is player_1_score, player_2_score
    expect(tennis_game.game_score.player_1).to eq player_1_score
    expect(tennis_game.game_score.player_2).to eq player_2_score
  end

end