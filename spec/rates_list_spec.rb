require 'nokogiri'
require './lib/rates_list.rb'
require './lib/urls.rb'

describe RatesList do
  let(:rate) { RatesList.new }
  let(:correct_url1) { Urls::EXCHANGE_RATES_URL }
  let(:correct_url2) { Urls::COUNTRY_CODES_URL }
  let(:wrong_url1) { 'https://bnr.rw/currency/exchange' }
  let(:wrong_url2) { 'https://pkgstore.datahub.io/core/currency-codes/' }

  describe '#save_data' do
    it 'creates a csv file named - exchange_rates.csv that contains extracted data' do
      rate.save_data(correct_url1, correct_url2)
      expect(File.exist?('exchange_rates.csv')).to eql(true)
    end
    it 'returns < Data not found> when passed wrong urls or the pages were modified' do
      expect(rate.save_data(wrong_url1, wrong_url2)).to eql('Data not found')
    end
  end
end
