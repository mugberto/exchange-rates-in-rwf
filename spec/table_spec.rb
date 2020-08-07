require_relative '../lib/table.rb'

describe Table do
  let(:table) { Table.new }
  describe '#draw' do
    let(:expected) do
      '
|Country        |Code|Date      |Buying value|Average value|Selling Value|
--------------------------------------------------------------------------
|UNITED ARAB EM-|AED |2020-08-03|254.443184  |256.987358   |259.531533   |
|IRATES (THE)   |    |          |            |             |             |
--------------------------------------------------------------------------
|ANGOLA         |AOA |2020-08-03|1.619675    |1.635870     |1.652065     |
--------------------------------------------------------------------------
'
    end
    it 'returns a string that is displayed as table in the terminal' do
      result = table.draw('test_sample.csv')
      expect(result).to eq(expected)
    end
    it 'returns < No path to data file given > when no path given' do
      result = table.draw
      expect(result).to eq('No path to data file given')
    end
    it 'returns < Data file not available > when given a wrong path' do
      result = table.draw('testsample.csv')
      expect(result).to eq('Data not available')
    end
    it 'returns < File format not recognized > when given a filename extension different from csv' do
      result = table.draw('testsample.html')
      expect(result).to eq('File format not recognized')
    end
  end
end
