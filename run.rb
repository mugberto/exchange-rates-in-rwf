#!/usr/bin/env ruby

require_relative 'lib/rates_list.rb'

rate = RatesList.new
rate.extract_rates
p rate.add_country_name
rate.save_data
# sleep 30
