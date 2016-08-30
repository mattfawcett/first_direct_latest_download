require "selenium-webdriver"

module FirstDirectLatestDownload
  class Download
    FIRST_DIRECT_URL = 'https://www1.firstdirect.com/1/2/pib-service'

    def initialize(options)
      @options = options
    end

    def run!
      driver = Selenium::WebDriver.for :chrome
      driver.navigate.to FIRST_DIRECT_URL

      element = driver.find_element(:name, 'userid')
      element.send_keys @options[:username]
      element.submit

      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { driver.find_element(:partial_link_text =>  'Log on without your Secure Key') }

      driver.find_element(partial_link_text: 'Log on without your Secure Key').click

      driver.find_element(name: 'memorableAnswer').send_keys(@options[:memorable_answer])

      (1..3).each { |n| fill_out_password_character(driver, n) }

      driver.find_element(xpath: "//*[@type='submit']").click

      wait.until { driver.find_element(:link_text =>  @options[:account_name]) }


      driver.find_element(:link_text, @options[:account_name]).click
      driver.find_element(:link_text, 'download').click

      wait.until { driver.find_element(:name =>  'DownloadFormat') }

      file_type = driver.find_element(:name, 'DownloadFormat')
      file_type.find_elements(:tag_name => "option").find do |option|
        option.text == ' Microsoft Excel '
      end.click

      driver.find_element(:link_text, 'download').click

      sleep 10

      driver.find_element(partial_link_text: 'log off').click
      driver.find_element(partial_link_text: 'confirm').click
      driver.quit
    end

    # field_number should be 1, 2 or 3
    def fill_out_password_character(driver, field_number)
      label = driver.find_element(id: "hiddenpasswordcharacterposition_#{field_number}-label")

      character_number = label.attribute('innerText').scan(/\d|penultimate/).first

      character = case character_number
        when "penultimate"
          @options[:password][@options[:password].length-2, 1]
        else
          @options[:password][character_number.to_i-1, 1]
        end

      field_id = label.attribute('for')

      driver.find_element(:id, field_id).send_keys(character)
    end
  end
end
