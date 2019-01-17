require 'selenium-webdriver'

class BasePage

  attr_reader :browser

  def initialize()
    case $browser
    when /IE/i
      @browser = Selenium::WebDriver.for :internet_explorer
    when /chrome/i
      options = Selenium::WebDriver::Chrome::Options.new(args: ['--start-maximized'])
      @browser = Selenium::WebDriver.for(:chrome, options: options)
      #@browser = Selenium::WebDriver.for :chrome
    when /firefox/i
      options = Selenium::WebDriver::Firefox::Options.new
      profile = Selenium::WebDriver::Firefox::Profile.new
      options.profile = profile
      options.add_preference("moz:webdriverClick", false)
      @browser = Selenium::WebDriver.for :firefox, options: options

      #Selenium::WebDriver::Firefox::Binary.path = '/Users/fabricioforuria/Documents/geckodriver'
      #@browser = Selenium::WebDriver.for :firefox
    else
      fail("First parameter Browser '#{$browser}' is not recognized. It must be: firefox, chrome, ie.")
    end
    @browser.manage.timeouts.implicit_wait = 5
    @browser.manage.delete_all_cookies
    @browser.manage.window.maximize

  end

  def type_on_hidden_input(locator, inputText)
    element = @browser.find_element(locator)[0]
    @browser..execute_script("document.getElementsByName('q')[0].focus();")
    @browser..execute_script("document.getElementsByName('q')[0].style.display='block';")

    @browser.action.move_to(element).click()
    @browser.action.perform()
  end

  def visit(url='/')
    browser.get($base_url + url)
  end

  def find(locator)
    browser.find_element(locator)[0]
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


  def teardown
    browser.quit
  end

end







