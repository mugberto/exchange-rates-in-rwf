require 'csv'

class Table
  def initialize
    @data = []
    @col_widths = []
    @max_col_width = 15
    @breaklines = 0
  end

  def draw(path)
    @data = CSV.read(path)
    col_widths
    table = ''
    @data.each do |row|
      line = ''
      row.each_with_index { |content, index| line += build_cell(@col_widths[index], content, index) }
      i = 1
      until @breaklines.zero?
        row.each_with_index { |content, index| line += build_wrap_cell(@col_widths[index], content, index, i) }
        i += 1
      end
      line << "\n" + '-' * (@col_widths.sum + @col_widths.size + 1)
      table << line
    end
    table << "\n"
  end

  private

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

  def build_cell(cell_size, data, index)
    if data.size <= cell_size
      (index.zero? ? "\n|" : '') + data + ' ' * (cell_size - data.size) + '|'
    else
      @breaklines = data.size / cell_size
      (index.zero? ? "\n|" : '') + data[0, cell_size - 1] + '-|'
    end
  end

  def build_wrap_cell(cell_size, data, index, line)
    if data.size <= cell_size
      (index.zero? ? "\n|" : '') + ' ' * cell_size + '|'
    elsif @breaklines == 1
      @breaklines = 0
      n = cell_size * (data.size / cell_size + 1)
      (index.zero? ? "\n|" : '') + data[(n - cell_size - line)..-1] + ' ' * (n - data.size - line) + '|'
    else
      @breaklines -= 1
      (index.zero? ? "\n|" : '') + data[(line * cell_size - 1), (cell_size - 1)] + '-|'
    end
  end
end
