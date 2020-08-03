require './lib/rates_list.rb'

# To run this test, delete 'exchange_rates.csv' file if it exists in your root folder
describe RatesList do
  let(:rate) { RatesList.new }
  describe '#save_data' do
    it 'creates a csv file named - exchange_rates.csv' do
      rate.save_data
      expect(File.exist?('exchange_rates.csv')).to eql(true)
    end
  end
end
