require 'selenium-webdriver'
require 'logger'

class BasePage

  attr_reader :browser

  def initialize(browser)
    @browser = browser
  end

  def execute_script_on_element(script, element)
    browser.execute_script(script, element)
  end

  def visit(url='/')
    browser.get($base_url + url)
  end

  def navigate(url)
    browser.navigate.to($base_url + url)
  end

  def scroll_to_element(elem)
    browser.action.move_to(elem).perform
  end

  def click_to_element(elem)
    browser.action.click(elem).perform
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

  def clear_log_file
    # Parameter File::CREAT ensures the log file will be re-created every time this method is called
  file = File.open('logger.log', File::WRONLY | File::APPEND | File::CREAT)
    logger = Logger.new(file)
  end

  # This method logs info for both log file and STDOUT.
  def log(text)
    log = Logger.new("| tee -a logger.log") # note the pipe ( '|' )
    log.info text # will log to both STDOUT and logger.log
  end

  # This method logs error for both log file and STDOUT.
  def error(text)
    log = Logger.new("| tee -a logger.log") # note the pipe ( '|' )
    log.error text # will log to both STDOUT and logger.log
  end
end





