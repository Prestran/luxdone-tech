require 'rails_helper'

RSpec.describe NbpCurrencyService do
  subject { NbpCurrencyService.new(currency, start_date, end_date).get_result }

  describe '#get_result?' do
    let(:expected_result) {
      {
        "standard_deviation": 0.1355,
        "average_price": 5.2525
      }
    }
    let(:currency) { "gbp" }
    let(:start_date) { "2012-01-01" }
    let(:end_date) { "2012-01-31" }

    context 'parameters are valid' do
      it 'return json with standard_deviation and average_price' do
        expect(subject).to eq(expected_result)
      end
    end

    context 'currency is invalid' do
      let(:currency) { 'qwerty' }
      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end

    context 'start_date is invalid' do
      let(:start_date) { '2012-0qwe1-01' }
      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end

    context 'end_date is invalid' do
      let(:end_date) { '2012-0qwe1-01' }
      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end
  end
end