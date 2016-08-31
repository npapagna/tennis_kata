require 'spec_helper'

class TennisGame

  def player_1_score
    0
  end

  def player_2_score
    0
  end

end

describe 'My behaviour' do

  let(:love) { 0 }
  let(:tennis_game) { TennisGame.new }

  it '001' do
    assert_game_score_is love, love
  end

  def assert_game_score_is player_1_score, player_2_score
    expect(tennis_game.player_1_score).to eq player_1_score
    expect(tennis_game.player_2_score).to eq player_2_score
  end
  
end