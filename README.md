# cinema-tests

E2E and manual tests for [cinema project](https://github.com/miloszhoc/cinema).

### Test cases

Test cases for manual testing
are [here](https://docs.google.com/spreadsheets/d/1waFV-8ZkhgdNZUMMdUEsn7iaLLuMzJ9fWcIrPRdYdkg/edit#gid=0).

### Technologies:

* python
* selenium
* selenium grid
* requests
* pytest
* pytest plugins:
    * pytest-dist
    * pytest-assume
    * pytest-html

### Locators

Locators are written in UPPER_CASE. There are 2 types of locators in this project:

* static locators - locators which are used in standard way. Each static locator has 'S' as a postfix.
* dynamic locators - locators needs to be used with `dynamic_locator()` function. This function takes locator as a
  argument and value which will be injected to locator. Function accepts either positional arguments or keyword
  arguments (e.g. `dynamic_locator((By.XPATH, '//a[contains(text(), "{}")]'), 'test')` - text 'test' will be inserted
  where the curly brackets are). Each dynamic locator has 'D' as a postfix.

### Pages

Page names are written in CamelCase. Each page has 'P' as a postfix. 
