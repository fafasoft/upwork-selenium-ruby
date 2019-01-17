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
  end
end












