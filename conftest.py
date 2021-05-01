import pytest
from env_data import APP_URL
from driver import CreateDriver


@pytest.hookimpl(hookwrapper=True)
def pytest_runtest_makereport(item, call):
    pytest_html = item.config.pluginmanager.getplugin("html")
    outcome = yield
    report = outcome.get_result()
    extra = getattr(report, "extra", [])
    if report.when == "call":
        # always add url to report
        xfail = hasattr(report, "wasxfail")
        if (report.skipped and xfail) or (report.failed and not xfail):
            # only add additional html on failure
            web_driver = item.funcargs['get_driver']
            image = web_driver.get_screenshot_as_base64()
            extra.append(pytest_html.extras.image(image))
        report.extra = extra


@pytest.fixture(autouse=True, scope='function')
def setup_browser():
    driver = CreateDriver()
    driver.set_driver('chrome', 'remote', '--headless', driver_path='drivers/chromedriver.exe')
    browser = driver.get_current_driver()
    browser.get(APP_URL)

    yield browser

    browser.quit()
