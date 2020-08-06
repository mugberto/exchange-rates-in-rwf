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

  def save_data(url1 = EXCHANGE_RATES_URL, url2 = COUNTRY_CODES_URL)
    File.delete('./exchange_rates.csv') if File.exist?('./exchange_rates.csv')
    return 'Data not found' if extract_rates(url1) == 'error'

    return 'Data not found' if add_country_name(url2) == 'error'

    @data.unshift @head
    CSV.open('./exchange_rates.csv', 'w') do |csv|
      @data.each { |d| csv << d }
    end
  end

  private

  def extract_rates(url)
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to url
    begin
      expand_element = driver.find_element(id: 'recordLimit')
      driver.action.click(expand_element).key_down(:arrow_down).key_down(:arrow_down).key_down(:enter).perform
      sleep 3
      rows = Nokogiri::HTML(driver.page_source).css('tbody tr')
      driver.quit
    rescue Selenium::WebDriver::Error::WebDriverError
      return 'error'
    rescue Nokogiri::CSS::Tokenizer::ScanError
      return 'error'
    rescue OpenURI::HTTPError
      return 'error'
    end
    rows.each do |row|
      row = row.css('td').map { |i| i.text.strip }
      row.shift
      @data << row
    end
  end

  def add_country_name(url)
    driver = Selenium::WebDriver.for :chrome
    begin
      driver.navigate.to url
      sleep 3
      country_list = CSV.parse(Nokogiri::HTML(driver.page_source).css('pre').text)
      driver.quit
    rescue Selenium::WebDriver::Error::WebDriverError
      return 'error'
    rescue Nokogiri::CSS::Tokenizer::ScanError
      return 'error'
    rescue OpenURI::HTTPError
      return 'error'
    end
    @data.each do |row|
      country_record = country_list.detect { |country| country[2] == row[0] }
      row.unshift country_record[0]
    end
  end
end
