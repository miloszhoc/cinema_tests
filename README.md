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
  against production environment `env` variable should equal `production`. Environments' test configuration can be found
  in [config.ini](./config.ini) file.

Tests which uses mailing system requires setting IMAP connection. It can be done by setting the following environmental
variables.

- `email_login` - login to an email account
- `email_passwd` - password to an email account
- `email_host` - IMAP host
- `email_port` - IMAP port

Tests which uses SQL queries requires establishing database connection. It can be done by setting the following
environmental variables.

- `db_name` - database name
- `db_user` - database user login
- `db_password` - database password
- `db_host` - database host
- `db_port` - database port

Tests can be run using `pytest` command.

### Production tests

Only tests which are marked as production should be run against production environment. These tests do not insert any
data into database. To run this kind of tests user should set `env` variable to `production` and
invoke `pytest -k production` command.

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
- production - used for marking tests which can be run only against production environment

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
- requests fixtures which uses requests module (these kinds of fixtures does not require starting browser). Requests
  fixtures are used mainly for creating test data.

# Files and folders

Description of the most important files and folders in this project.

* drivers - drivers for local tests execution,
* pom - page object model's classes,
* sql - SQL queries and execution function
* tests - test cases
* utils - classes for handling emails, date operations, and creating test data with requests
* config.ini - stores the most important variables (accounts credentials, Grid URL etc.)
* conftest.py - pytest fixtures shared among all tests
* driver.py - stores driver's configuration class and methods for updating driver's cookies
* env_data.py - reads _config.ini_ file.
* pytest.ini - file for customising pytest behaviour
* requests_fixtures.py - fixtures which uses requests module
* requirements.txt - packages required for running tests environment
