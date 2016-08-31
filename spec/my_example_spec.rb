require 'spec_helper'

class TennisGame

  def initialize
    @player_1_serving = true
    @player_1_score = 0
    @player_2_score = 0
  end

  def player_1_score
    @player_1_score
  end

  def player_2_score
    @player_2_score
  end

  def win_point
    if @player_1_serving
      if @player_1_score == 0
        @player_1_score = 15
        return
      end

      if @player_1_score == 15
        @player_1_score = 30
        return
      end

      if @player_1_score == 30
        @player_1_score = 40
        return
      end

      if @player_1_score == 40
        @player_1_score = :game
        return
      end

      fail 'Game over'
    else
      @player_2_score = 15
    end
  end

  def lose_point
    @player_1_serving = false
  end

end

describe 'My behaviour' do

  let(:love) { 0 }
  let(:fifteen) { 15 }
  let(:thirty) { 30 }
  let(:forty) { 40 }
  let(:game) { :game }
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

  def assert_game_score_is player_1_score, player_2_score
    expect(tennis_game.player_1_score).to eq player_1_score
    expect(tennis_game.player_2_score).to eq player_2_score
  end

end