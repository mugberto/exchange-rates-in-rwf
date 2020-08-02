require 'csv'

class Table
  def initialize
    @data = []
    @col_widths = []
  end

  def draw(path)
    @data = CSV.read(path)
    col_widths
  end

  def col_widths
    cols = @data.max { |a, b| a.length <=> b.length }
    cols.size.times do |i|
      arr = []
      @data.each do |row|
        arr << row[i].length
      end
      @col_widths[i] = arr.max <= 15 ? arr.max : @max_col_width
    end
  end
end
