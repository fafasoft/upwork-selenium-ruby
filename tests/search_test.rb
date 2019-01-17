#!/usr/bin/env ruby

require "selenium/webdriver"
require_relative '../pages/UpworkHomePage'

class TestSearchKeyword
  $base_url = "http://www.upwork.com"
  $browser = ARGV[0]
  $keyword = ARGV[1]

  def test_search_keyword
    upworkHomePage = UpworkHomePage.new()
    sleep 20
    upworkHomePage.search_for($keyword)
    upworkHomePage.teardown


    #puts "title of webpage is: #{browser.title()}"
    #browser.quit()
    #assert_equal(4, SimpleNumber.new(2).add(2) )
    #assert_equal(6, SimpleNumber.new(2).multiply(3) )
  end
end












