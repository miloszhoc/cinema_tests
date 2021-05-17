import requests
from requests import Session
from selenium import webdriver
from env_data import SELENIUM_HUB_URL


class CreateDriver():
    CHROME = {
        "browserName": "chrome",
        "javascriptEnabled": True,
    }

    def __init__(self):
        self._browser = None
        self._platform = None
        self._env = None
        self._caps = None
        self._browser_arguments = None
        self._driver: webdriver.Chrome = None

    def set_driver(self, browser: str, env: str, driver_path=None, *args, **kwargs):
        """
        Configure webdriver.

        :param browser: browser name (np. chrome, firefox)
        :param env: environment (remote, local)
        :param args: additional arguments passed to browser
        :param kwargs: additional arguments passed to driver
        :param driver_path: path to local chromedriver
        """
        self._browser = browser.lower()
        self._env = env.lower()
        self._browser_arguments = args

        if self._browser == 'chrome':
            options = webdriver.ChromeOptions()
            options.add_argument('--window-size=1920,1080')

            if args:
                for argument in args:
                    options.add_argument(argument)

            self.CHROME.update(options.to_capabilities())

            if env == 'local':
                self._driver = webdriver.Chrome(executable_path=driver_path, desired_capabilities=self.CHROME, **kwargs)
            elif env == 'remote':
                self._driver = webdriver.Remote(command_executor=SELENIUM_HUB_URL,
                                                desired_capabilities=self.CHROME)
        self._driver.set_page_load_timeout(60)

    def get_current_driver(self) -> webdriver.Chrome:
        """
        :return: current driver instance
        """
        if self._driver is None:
            print('No existing webdriver instance\n Use  set_driver() method')
            return
        return self._driver


def update_session_cookies(browser: webdriver.Chrome) -> Session:
    """
    Pass cookies from selenium library to requests
    """
    cookies = browser.get_cookies()
    session = Session()
    for cookie in cookies:
        session.cookies.set(cookie['name'], cookie['value'])
    return session


def update_browser_cookies(session: Session, browser: webdriver.Chrome) -> webdriver.Chrome:
    """
    Pass cookies from requests library to selenium
    """
    browser.delete_all_cookies()
    for k, v in session.cookies.items():
        browser.add_cookie({'name': k, 'value': v})
    browser.refresh()
    return browser
