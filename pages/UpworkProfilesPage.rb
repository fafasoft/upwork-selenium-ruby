require_relative "../pages/BasePage"
require 'json'

class UpworkProfilesPage < BasePage
  @@array = []
  @@n = nil
  RESULTS = { css: "section[data-qa='freelancer'] div.col-xs-12.p-0-right div[data-ng-click]" }
  TITLES = { css: "h4[data-qa='tile_title']" }
  DESCRIPTION = { css: "o-profile-overview p[itemprop='description']" }
  TITLE = { css: "o-profile-overview p[itemprop='description']" }
  NAME = { css: ".media-body span[itemprop='name']" }

  def initialize(driver)
    super
  end

  # This method parses search results and creates a JSON file with them for verification
  def check_keyword_results
    i = 0
    # This boolean variable is set to false in advance for every freelancer and set to true only if any condition is met
    keyword_is_present = false
    wait_for { displayed?(RESULTS) }
    results_array =  get_array(RESULTS)

    # This method iterates on the results array only for the first 10 elements (1st page of results)
    results_array.each do |elem|
      i=i+1
      if(i > 10)
        break
      end
      # For each element it is extracted this attribute and uses regex expression to take only {...} to create JSON file
      results_json = elem.attribute("data-ng-click").match(/\{(.*)\}/).to_s
      json_file = JSON.parse(results_json.to_s)
      # Extracting from JSON created only the fields that we need for verification against the keyword searched
      short_name = json_file['shortName'].to_s
      title = json_file['title'].to_s
      description = json_file['description'].to_s
      skills = json_file['skills'].to_s
      # Creating a hash for each freelancer
      hash =  {:name => short_name.to_s, :description => description.to_s, :title => title.to_s, :skills => skills.to_s}
      # Pushing each hash created to an array variable that will be used on the verification
      @@array.push(hash)
    end
    log "STEP 7: Parse the 1st page with search results: store info given on the 1st page of search results as structured data of any chosen by you type (i.e. hash of hashes or array of hashes, whatever structure handy to be parsed)."
    log "STEP 8: Make sure at least one attribute (title, overview, skills, etc) of each item (found freelancer) from parsed search results contains '#{$keyword}' Log in stdout which freelancers and attributes contain '#{$keyword}' and which do not."
    # Iterating over the first page results array
    @@array.each do |freelancer|
      # Extracting data from each hash
      title = freelancer[:title].to_s
      description = freelancer[:description].to_s
      skills = freelancer[:skills].to_s
      keyword = $keyword.to_s
      # Verifies whether keyword is present on any field of each, if so keyword_is_present = true (avoiding a test failure)
      if title.include?(keyword.to_s)
        keyword_is_present = true
      elsif description.include?(keyword.to_s)
        keyword_is_present = true
      elsif skills.include?(keyword.to_s)
        keyword_is_present = true
      end
      # Verification: for each freelancer, if keyword_is_present is false, then keyword was not present on all important fields
      if keyword_is_present == false
        # log which freelancer is
        log "ERROR!!! => Description differs between profiles search results and freelancer profile for #{@@array[@@n.to_i][:name].to_s}."
        puts "freelancer failed: #{freelancer[:name].to_s}"
        # In addition of logging this failure, the whole test case needs to be marked as FAILED by setting global variable $test_result
        $test_result = false
      else
        puts "freelancer passed: #{freelancer[:name].to_s}"
      end
    end
  end

  # This method selects a random title element and then scrolls and clicks to it for verification
  def check_profile_attributes_match
    wait_for { displayed?(TITLES) }
    titles_array =  get_array(TITLES)
    # @@n variable is a random integer that is used as index for selecting only one of the titles elements array
    @@n = rand(0...9)
    log "STEP 9: Click on random freelancer's title."
    # For scrolling the page to the randomly selected title element it uses javascript executor instead of actions
    execute_script_on_element "arguments[0].scrollIntoView(true);", titles_array[@@n.to_i]
    # This fixed explicit sleep ensures reliability after scrolling and clicking on the element
    sleep 5
    log "STEP 10: Get into that freelancer's profile (by clicking on desired Freelancer's title)."
    # Following the same logic and strategy for scrolling, we use again this method for click
    execute_script_on_element "arguments[0].click();", titles_array[@@n.to_i]

    # After clicking on the freelancer's title we wait until the slide window is open and freelancer profile elements are present
    wait_for { displayed?(DESCRIPTION) }
    description = text_of(DESCRIPTION)
    log "STEP 11: Check that each attribute value is equal to one of those stored in the structure created in STEPS 7 and 8."
    log "STEP 12: Check whether at least one attribute contains #{$keyword}."

    if (description.to_s.eql? @@array[@@n.to_i][:description].to_s)
      $test_result = false
      error "ERROR!!! => Description differs between profiles search results and freelancer profile for #{@@array[@@n.to_i][:name].to_s}."
    end
    wait_for { displayed?(TITLE) }
    description = text_of(TITLE)
    if (description.to_s.eql? @@array[@@n.to_i][:description].to_s)
      $test_result = false
      error "ERROR: Title differs between profiles search results and freelancer profile for #{@@array[@@n.to_i][:name].to_s}."
    end
  end


end