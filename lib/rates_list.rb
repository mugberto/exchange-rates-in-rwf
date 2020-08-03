require 'nokogiri'
require 'selenium-webdriver'
require 'csv'
require 'open-uri'
require_relative './urls.rb'

class RatesList
  include Urls

  def initialize
    @head = ['Country', 'Code', 'Date', 'Buying value', 'Average value', 'Selling Value']
    @data = []
  end

  def save_data
    extract_rates
    add_country_name
    @data.unshift @head
    CSV.open('./exchange_rates.csv', 'w') do |csv|
      @data.each { |d| csv << d }
    end
  end

  private

  def extract_rates
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to EXCHANGE_RATES_URL
    expand_element = driver.find_element(id: 'recordLimit')
    driver.action.click(expand_element).key_down(:arrow_down).key_down(:arrow_down).key_down(:enter).perform
    sleep 3
    rows = Nokogiri::HTML(driver.page_source).css('tbody tr')
    driver.quit
    rows.each do |row|
      row = row.css('td').map { |i| i.text.strip }
      row.shift
      @data << row
    end
  end

  def add_country_name
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to COUNTRY_CODES_URL
    country_list = CSV.parse(Nokogiri::HTML(driver.page_source).css('pre').text)
    driver.quit
    @data.each do |row|
      country_record = country_list.detect { |country| country[2] == row[0] }
      row.unshift country_record[0]
    end
  end
end
