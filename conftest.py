import pytest
from env_data import APP_URL
from driver import CreateDriver
from utils.testlink import TestLinkReport

pytest_plugins = ('requests_fixtures',)


def pytest_addoption(parser):
    parser.addoption("--testplan", action="store", default="")
    parser.addoption("--build", action="store", default="")


@pytest.hookimpl(hookwrapper=True)
def pytest_runtest_makereport(item, call):
    pytest_html = item.config.pluginmanager.getplugin("html")
    outcome = yield
    report = outcome.get_result()
    extra = getattr(report, "extra", [])
    if report.when == "call":

        # get test case id from test name and convert it into testlink format
        testcase_id = report.nodeid.split("::")[1].split('_')[1].capitalize()
        testcase_id = [i for i in testcase_id]
        testcase_id.insert(1, '-')
        testcase_id = ''.join(testcase_id)

        t = TestLinkReport()
        # mark test as passed or failed in testlink
        if report.outcome == 'passed':
            t.report_test_case(testcase_id, 'p', item.config.getoption("testplan"), item.config.getoption("build"))
        elif report.outcome == 'failed':
            t.report_test_case(testcase_id, 'f', item.config.getoption("testplan"), item.config.getoption("build"))

        xfail = hasattr(report, "wasxfail")
        if (report.skipped and xfail) or (report.failed and not xfail):
            # only add additional html on failure
            if 'setup_browser' in item.funcargs:
                web_driver = item.funcargs['setup_browser']
                extra.append(pytest_html.extras.html(f'<div>URL: {str(web_driver.current_url)}</div>'))
                extra.append(pytest_html.extras.html(f'cookies: <div>{str(web_driver.get_cookies())}</div>'))
                extra.append(pytest_html.extras.html(f'cache: <div>{str(web_driver.application_cache)}</div>'))
                extra.append(pytest_html.extras.html(f'browser logs: <div>{str(web_driver.get_log("browser"))}</div>'))
                image = web_driver.get_screenshot_as_base64()
                extra.append(pytest_html.extras.image(image))
        report.extra = extra


@pytest.fixture(scope='function')
def setup_browser():
    driver = CreateDriver()
    # driver.set_driver('chrome', 'local', './drivers/chromedriver.exe', '--headless')
    driver.set_driver('chrome', 'local', './drivers/chromedriver.exe')
    # driver.set_driver('chrome', 'remote')
    browser = driver.get_current_driver()

    yield browser

    browser.quit()


@pytest.fixture(scope='function')
def get_client_module(setup_browser):
    browser = setup_browser
    browser.get(APP_URL)

    return browser


@pytest.fixture(scope='function')
def get_worker_module(setup_browser):
    browser = setup_browser
    browser.get(APP_URL + '/worker')

    return browser
