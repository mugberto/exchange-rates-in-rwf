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
  end
end
