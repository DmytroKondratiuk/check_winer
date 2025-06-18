# frozen_string_literal: true

require_relative '../bet_cheker'

RSpec.describe BetCheker do
  let(:winer_result) { BetCheker.new(result:, bet:).result_of_bet }

  context 'when inputs are correct and match exactly' do
    let(:result) { '2:1' }
    let(:bet) { '2:1' }

    fit 'returns 1 for exact match' do
      expect(winer_result).to eq(1)
    end
  end

  context 'when final outcome matches but not exact score' do
    let(:result) { '3:2' }
    let(:bet) { '1:0' }

    it 'returns 0 for correct outcome' do
      expect(winer_result).to eq(0)
    end
  end

  context 'when the result and bet are completely wrong' do
    let(:result) { '1:2' }
    let(:bet) { '3:1' }

    it 'returns -1' do
      expect(winer_result).to eq(-1)
    end
  end

  describe 'inputs are invalid' do
    context 'when not valid result like "2"' do
      let(:result) { '2' }
      let(:bet) { '1:1' }

      it 'returns error message for bad format' do
        expect(winer_result).to eq('Invalid result or bet inputs')
      end
    end

    context 'when not valid bet like "-1:2"' do
      let(:result) { '1:1' }
      let(:bet) { '-1:2' }

      it 'returns error message for negative numbers' do
        expect(winer_result).to eq('Invalid result or bet inputs')
      end
    end

    context 'when result is like "a:b"' do
      let(:result) { 'a:b' }
      let(:bet) { '1:1' }

      it 'returns error message for non-numeric input' do
        expect(winer_result).to eq('Invalid result or bet inputs')
      end
    end
  end
end