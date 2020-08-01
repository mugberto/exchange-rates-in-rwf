require 'csv'
require 'nokogiri'
require 'selenium-webdriver'
require 'open-uri'
require_relative './urls.rb'

class RatesList
  include Urls

  def initialize
    @head = ['Country', 'Code', 'Date', 'Buying value', 'Average value', 'Selling Value']
    @data = []
  end

  def extract_rates
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to EXCHANGE_RATES_URL
    expand_element = driver.find_element(id: 'recordLimit')
    driver.action.click(expand_element).key_down(:arrow_down).key_down(:arrow_down).key_down(:enter).perform
    rows = Nokogiri::HTML(driver.page_source).css('tbody tr')
    rows.each do |row|
      row = row.css('td').map(&:text)
      row.shift
      @data << row
    end
    @data
  end

  def add_country_name
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to COUNTRY_CODES_URL
    country_list = CSV.parse(Nokogiri::HTML(driver.page_source).css('pre').text)
    @data.each do |row|
      country_record = country_list.detect { |country| country[2] == row[0] }
      row.unshift country_record[0]
    end
    @data
  end
end
