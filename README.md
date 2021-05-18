# cinema-tests

E2E and manual tests for [cinema project](https://github.com/miloszhoc/cinema).

## Test cases

Test cases for manual testing
are [here](https://docs.google.com/spreadsheets/d/1waFV-8ZkhgdNZUMMdUEsn7iaLLuMzJ9fWcIrPRdYdkg/edit#gid=0).

## Technologies:

* python
* selenium
* selenium grid
* requests
* pytest
* pytest plugins:
    * pytest-xdist
    * pytest-assume
    * pytest-html

## Running tests

In order to run tests it is required to set environmental variable `env` which chooses SUT's (System Under Test)
environment. There are currently 2 environments - staging and production. In order to run tests against staging
environment `env` variable should equal `staging`. To run tests against production environment `env` variable should
equal `prod`. Environments' test configuration can be found in [config.ini](./config.ini) file.

Tests can be run using `pytest` command.

### Run with HTML report

Test supports pytest-html reports. To run tests with report user should
run `pytest --html=<output__file_name.html> --self-contained-html` command. Report contains stacktrace, screen, and some
additional info (like application's page URL where error occurred or browser logs) for making debugging easier.
Repository contains [example html report](./example_report.html).

### Parallel execution

For parallel tests execution tests uses pytest plugin - _pytest-dist_. To run tests in parallel user should
run `pytest -n=<number of cpus>` command.

### Markers

todo markers support

# POM

### Locators

Locators are written in UPPER_CASE. There are 2 types of locators in this project:

* static locators - locators which are used in standard way. Each static locator has 'S' as a postfix.
* dynamic locators - locators needs to be used with `dynamic_locator()` function. This function takes locator as an
  argument and value which will be injected to locator. Function accepts either positional arguments or keyword
  arguments (e.g. `dynamic_locator((By.XPATH, '//a[contains(text(), "{}")]'), 'test')` - text 'test' will be inserted
  where the curly brackets are). Each dynamic locator has 'D' as a postfix.

### Pages

Page names are written in CamelCase. Each page has 'P' as a postfix. 
