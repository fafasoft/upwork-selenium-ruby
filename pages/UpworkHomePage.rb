require_relative "../pages/BasePage"

class UpworkHomePage < BasePage

  SEARCH_TEXTBOX = { css: "input[data-o-freelancer-search-input]" }
  SEARCH_BUTTON = { css: "span.air-icon-search" }
  FREELANCER_OPTION = { link_text: "Freelancers" }
  SELECT_SEARCH_DROPDOWN = { xpath: "//span[@class='caret glyphicon air-icon-arrow-expand']" }

  def initialize(driver)
    super
    visit
    text = "Upwork - Hire Freelancers"
    verify_page text
  end

  def search_for(search_term)
    wait_for { displayed?(SEARCH_TEXTBOX) }
    type_on_hidden_input(SEARCH_TEXTBOX, search_term)
    type SEARCH_TEXTBOX, search_term
    wait_for { displayed?(SEARCH_BUTTON) }
    click_on SEARCH_BUTTON
  end

  def set_freelancer_option
    wait_for { displayed?(SELECT_SEARCH_DROPDOWN) }
    click_on SELECT_SEARCH_DROPDOWN
    wait_for { displayed?(FREELANCER_OPTION) }
    click_on FREELANCER_OPTION
    wait_for { displayed?(FREELANCER_OPTION) }
  end
end