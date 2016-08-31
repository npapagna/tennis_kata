require 'spec_helper'

class TennisGame

  def initialize
    @player_1_score = 0
  end

  def player_1_score
    @player_1_score
  end

  def player_2_score
    0
  end

  def win_point
    if @player_1_score == 0
      @player_1_score = 15
      return
    end

    if @player_1_score == 15
      @player_1_score = 30
      return
    end

    @player_1_score = 40
  end

end

describe 'My behaviour' do

  let(:love) { 0 }
  let(:fifteen) { 15 }
  let(:thirty) { 30 }
  let(:forty) { 40 }
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

  def assert_game_score_is player_1_score, player_2_score
    expect(tennis_game.player_1_score).to eq player_1_score
    expect(tennis_game.player_2_score).to eq player_2_score
  end
  
end