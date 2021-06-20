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

In order to run tests it is required to set environmental variables:

- `env` variable which chooses SUT's (System Under Test) environment. There are currently 2 environments - staging and
  production. In order to run tests against staging environment `env` variable should equal `staging`. To run tests
  against production environment `env` variable should equal `prod`. Environments' test configuration can be found
  in [config.ini](./config.ini) file.

Tests which uses mailing system requires setting IMAP connection. It can be done by setting the following environmental
variables.

- `EMAIL_LOGIN` - login to an email account
- `EMAIL_PASSWD` - password to an email account
- `EMAIL_HOST` - IMAP host
- `EMAIL_PORT` - IMAP port

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

This project uses pytest's markers for choosing which tests needs to be run. The following markers are available:

- mail - used for marking tests which requires reading incoming emails

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

## Emails

Tests use imaplib library and gmail account to handling incoming emails.

# Preconditions

There are two types of fixtures in this project:

- standard fixtures which starts web browser
- requests fixtures which uses requests module (these kinds of locators does not require starting browser). Requests
  fixtures are used mainly for creating test data.

