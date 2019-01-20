#!/usr/bin/env ruby
require 'selenium-webdriver'
require_relative '../pages/UpworkHomePage'
require_relative '../pages/UpworkProfilesPage'

class TestSearchKeyword
  @driver = nil
  $base_url = "http://www.upwork.com"
  $browser = ARGV[0]
  $keyword = ARGV[1]
  # This boolean variable is set to true in advance for every test and set to false only if any condition is not met
  $test_result = true

  def init_driver
    case $browser
    when /IE/i
      @driver = Selenium::WebDriver.for :internet_explorer
    when /chrome/i
      @driver = Selenium::WebDriver.for :chrome
    when /firefox/i
      @driver = Selenium::WebDriver.for :firefox
    else
      fail("First parameter Browser '#{$browser}' is not recognized. It must be: firefox, chrome, ie.")
    end
    @driver.manage.timeouts.implicit_wait = 10
    @driver.manage.delete_all_cookies
    @driver.manage.window.maximize
  end

  def test_search_keyword
    init_driver
    upwork_profiles_page.log ":::::::::: TEST : GIVEN THAT ANONYMOUS USER IS ON LANDING PAGE WHEN SEARCH FOR A KEYWORD THEN ALL FREELANCERS RESULTS SHOWN HAVE THAT SAME KEYWORD IN SOME FIELDS ::::::::::"
    upwork_home_page = UpworkHomePage.new(@driver)
    upwork_home_page.search_for($keyword.to_s)
    upwork_profiles_page = UpworkProfilesPage.new(@driver)
    upwork_profiles_page.check_keyword_results
    upwork_profiles_page.check_profile_attributes_match
    if $test_result == false
      upwork_profiles_page.error "TEST FAILED!!!"
    else
      upwork_profiles_page.log "TEST PASSED WITH SUCCESS."
    end
    upwork_home_page.teardown
  end
end





