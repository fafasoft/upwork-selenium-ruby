#!/usr/bin/env ruby

require "selenium/webdriver"
require_relative '../pages/UpworkHomePage'
require_relative '../pages/UpworkProfilesPage'

class TestSearchKeyword
  @driver = nil
  $base_url = "http://www.upwork.com"
  $browser = ARGV[0]
  $keyword = ARGV[1]
  $test_result = true

  def init_driver
    case $browser
    when /IE/i
      @driver = Selenium::WebDriver.for :internet_explorer
    when /chrome/i
      options = Selenium::WebDriver::Chrome::Options.new(args: ['--start-maximized'])
      @driver = Selenium::WebDriver.for(:chrome, options: options)
      #browser = Selenium::WebDriver.for :chrome
    when /firefox/i
      options = Selenium::WebDriver::Firefox::Options.new
      profile = Selenium::WebDriver::Firefox::Profile.new
      options.profile = profile
      options.add_preference("moz:webdriverClick", false)
      @driver = Selenium::WebDriver.for :firefox, options: options

      #Selenium::WebDriver::Firefox::Binary.path = '/Users/fabricioforuria/Documents/geckodriver'
      #@browser = Selenium::WebDriver.for :firefox
    else
      fail("First parameter Browser '#{$browser}' is not recognized. It must be: firefox, chrome, ie.")
    end
    @driver.manage.timeouts.implicit_wait = 10
    @driver.manage.delete_all_cookies
    @driver.manage.window.maximize
  end

  def test_search_keyword
    init_driver
    upworkHomePage = UpworkHomePage.new(@driver)
    #upworkHomePage.search_for($keyword.to_s)
    url = "/o/profiles/browse/?nbs=1&q=" + $keyword.to_s
    upworkHomePage.navigate url
    upworkProfilesPage = UpworkProfilesPage.new(@driver)
    upworkProfilesPage.checkKeywordResults
    if $test_result == false
      puts "TEST FAILED!"
    else
      puts "TEST PASSES."
    end
    upworkHomePage.teardown
  end
end












