require_relative "../pages/BasePage"
require 'json'

class UpworkProfilesPage < BasePage
  @results_array = nil
  @results_json = nil
  @json_file = nil
  RESULTS = { css: "section[data-qa='freelancer'] div.col-xs-12.p-0-right div[data-ng-click]" }

  def initialize(driver)
    super
  end

  def checkKeywordResults
    i = 0
    keywordIsPresent = false
    wait_for { displayed?(RESULTS) }
    @results_array =  get_array(RESULTS)
    puts "array size: " + @results_array.length.to_s
    @results_array.each do |item|
      i=i+1
      @results_json = item.attribute('data-ng-click').match(/\{(.*)\}/).to_s
      @json_file = JSON.parse(@results_json)
      shortName = @json_file['shortName']
      title = @json_file['title']
      description = @json_file['description']
      skills = @json_file['skills']
      puts "interation: " + i.to_s
      puts "shortName: " + shortName
      puts "title: " + title
      if title.upcase.include? $keyword.to_s.upcase
        keywordIsPresent = true
        elseif description.upcase.include? $keyword.to_s.upcase
          keywordIsPresent = true
          elseif skills.upcase.include? $keyword.to_s.upcase
            keywordIsPresent = true
      end
      if keywordIsPresent == false
        # log which freelancer is
        #puts "freelancer failed: " + shortName
        $test_result = false
      else
        # log which freelancer is
      end
    end

  end

end