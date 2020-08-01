#!/usr/bin/env ruby

require_relative 'lib/rates_list.rb'

rate = RatesList.new
p rate.extract_rates
sleep 30
