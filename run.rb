#!/usr/bin/env ruby

require_relative 'lib/rates_list.rb'

rate = RatesList.new
rate.extract_rates
p rate.add_country
# sleep 30
