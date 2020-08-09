#!/usr/bin/env ruby

require_relative 'lib/rates_list.rb'
require_relative 'lib/table.rb'

rates = RatesList.new
rates.save_data
table = Table.new
puts table.draw('./exchange_rates.csv')
