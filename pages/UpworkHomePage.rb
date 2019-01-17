require_relative "../pages/BasePage"

class UpworkHomePage < BasePage

  SEARCH_TEXTBOX = { xpath: "//input[@name='q']" }
  SEARCH_BUTTON = { css: "span.air-icon-search" }
  FREELANCER_OPTION = { link_text: "Freelancers" }
  SELECT_SEARCH_DROPDOWN = { xpath: "//span[@class='caret glyphicon air-icon-arrow-expand']" }

  def initialize()
    super
    visit
    verify_page
  end

  def search_for(search_term)
    #wait_for { displayed?(SEARCH_TEXTBOX) }
    type_on_hidden_input(SEARCH_TEXTBOX, search_term)
    type SEARCH_TEXTBOX, search_term
    wait_for { displayed?(SEARCH_BUTTON) }
    click_on SEARCH_BUTTON
  end

  def search_result_present?(search_result)
    wait_for { displayed?(TOP_SEARCH_RESULT) }
    text_of(TOP_SEARCH_RESULT).include? search_result
  end

  def set_freelancer_option
    wait_for { displayed?(SELECT_SEARCH_DROPDOWN) }
    click_on SELECT_SEARCH_DROPDOWN
    wait_for { displayed?(FREELANCER_OPTION) }
    click_on FREELANCER_OPTION
    wait_for { displayed?(FREELANCER_OPTION) }
  end

  private

  def verify_page
    wait_for { title.include?("Upwork - Hire Freelancers") }
  end
end