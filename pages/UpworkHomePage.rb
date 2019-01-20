require_relative "../pages/BasePage"

class UpworkHomePage < BasePage

  SEARCH_TEXTBOX = { css: "div.navbar-collapse.d-none.d-lg-flex div.navbar-form form[role='search'] input[data-o-freelancer-search-input]" }
  SEARCH_BUTTON = { css: "div.navbar-collapse.d-none.d-lg-flex div.navbar-form form[role='search'] button[type=submit]" }
  TITLE_TEXT = "Upwork - Hire Freelancers"

  def initialize(driver)
    super
    # For every test run, the file logger.log is overwritten
    clear_log_file
    log "STEP 1: Run #{$browser} browser."
    log "STEP 2: Clear the browser #{$browser} cookies."
    log "STEP 3: Navigate to the following URL: #{$base_url}."
    visit
    verify_page TITLE_TEXT
  end

  def search_for(search_term)
    # This method executes the freelancer's search given the keyword given
    log "STEP 4: Focus onto 'Find freelancers' on the top dropdown."
    wait_for { displayed?(SEARCH_TEXTBOX) }
    log "STEP 5: Select 'Find Freelancers' on the top dropdown and enter #{$keyword} and submit it (click on the magnifying glass button)."
    #type_on_hidden_input(SEARCH_TEXTBOX, search_term)
    type SEARCH_TEXTBOX, search_term
    wait_for { displayed?(SEARCH_BUTTON) }
    log "STEP 6: Click on the magnifying glass button and submit it."
    click_on SEARCH_BUTTON
  end
end