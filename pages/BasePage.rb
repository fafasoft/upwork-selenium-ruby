require 'selenium-webdriver'

class BasePage

  attr_reader :browser

  def initialize(browser)
    @browser = browser
  end

  def type_on_hidden_input(locator, inputText)
    element = browser.find_element(locator)
    browser.execute_script("arguments[0].focus();", element )
    browser.execute_script("arguments[0].setAttribute('style', 'block');", element )
    browser.action.move_to(element).click()
    browser.action.perform()
  end

  def visit(url='/')
    browser.get($base_url + url)
  end

  def navigate(url)
    browser.navigate.to($base_url + url)
  end

  def find(locator)
    browser.find_element(locator)
  end

  def get_array(locator)
    browser.find_elements(locator)
  end

  def clear(locator)
    find(locator).clear
  end

  def type(locator, input)
    find(locator).send_keys input
  end

  def click_on(locator)
    find(locator).click
  end

  def displayed?(locator)
    browser.find_element(locator).displayed?
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def text_of(locator)
    find(locator).text
  end

  def title
    browser.title
  end

  def wait_for(seconds=5)
    Selenium::WebDriver::Wait.new(:timeout => seconds).until { yield }
  end

  def verify_page(text)
    wait_for { title.include?(text.to_s) }
  end

  def teardown
    browser.quit
  end

end







