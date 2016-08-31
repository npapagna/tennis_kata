require 'spec_helper'

Love = :love
Fifteen = :fifteen
Thirty = :thirty
Forty = :forty
Game = :game
Deuce = :deuce

class GameScore

  def initialize
    @player_1_score = Love
    @player_2_score = Love
  end

  def player_1
    @player_1_score
  end

  def player_2
    @player_2_score
  end

  def player_1_scored
    if @player_1_score == Love
      @player_1_score = Fifteen
      return
    end

    if @player_1_score == Fifteen
      @player_1_score = Thirty
      return
    end

    if @player_1_score == Thirty
      @player_1_score = Forty
      return
    end

    if @player_1_score == Forty
      @player_1_score = Game
      return
    end

    fail 'Game over'
  end

  def player_2_scored
    if @player_2_score == Love
      @player_2_score = Fifteen
      return
    end

    if @player_2_score == Fifteen
      @player_2_score = Thirty
      return
    end

    if @player_2_score == Thirty
      @player_2_score = Forty
      return
    end

    if @player_2_score == Forty
      @player_2_score = Game
      return
    end

    fail 'Game over'
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
      @game_score.player_1_scored
    else
      @game_score.player_2_scored
    end

    if @game_score.player_1 == Forty && @game_score.player_2 == Forty
      @game_score = Deuce
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

  def assert_game_score_is player_1_score, player_2_score
    expect(tennis_game.game_score.player_1).to eq player_1_score
    expect(tennis_game.game_score.player_2).to eq player_2_score
  end

end