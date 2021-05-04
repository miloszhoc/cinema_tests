import pytest
from selenium import webdriver

from driver import update_browser_cookies, update_session_cookies
from env_data import APP_URL
from bs4 import BeautifulSoup


@pytest.fixture(scope='function')
def login_logout(get_worker_module):
    browser = get_worker_module

    def login_as(login: str, passwd: str, module_endpoint: str) -> webdriver.Chrome:
        nonlocal browser, session
        browser.get(APP_URL + '/worker/login/')
        page_source = browser.page_source
        csrf = BeautifulSoup(page_source, 'html.parser').find('input', {'name': "csrfmiddlewaretoken"}).get('value')
        session = update_session_cookies(browser)
        session.headers['Cookie'] = 'csrftoken=' + session.cookies.get('csrftoken')
        session.post(APP_URL + '/worker/login/', data={'username': login,
                                                       'password': passwd,
                                                       'csrfmiddlewaretoken': csrf})
        browser = update_browser_cookies(session, browser)
        browser.get(APP_URL + module_endpoint)
        return browser

    yield login_as
    browser.get(APP_URL + '/worker/panel')
    session = update_session_cookies(browser)
    session.headers['Cookie'] = 'csrftoken=' + session.cookies.get(
        'csrftoken') + ',' + 'sessionid=' + session.cookies.get('sessionid')
    session.get(APP_URL + '/worker/logout/')
    session.cookies.clear_session_cookies()
    browser = update_browser_cookies(session, browser)
    browser.get(APP_URL + '/worker/panel')
