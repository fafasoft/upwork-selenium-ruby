
:::::: FABRICIO FORURIA :::::: SUN 20 JANUARY 2019 ::::::

Notes: This framework will be improved by using https://test-unit.github.io/
For this example, only selenium-webdriver gem was allowed.

To run the test:

1. Install gemfiles with: bundler install
2. Run the following command: ("firefox" is the first argument, it could be "chrome" instead or "ie", and "Ruby" is any keyword the user wants to search for in freelancers.

ruby -r ./tests/search_test.rb -e TestSearchKeyword.new.test_search_keyword firefox Ruby


A logger.log file will be created at the end. 

:::::::::::
