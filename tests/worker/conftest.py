import pytest
from pom.worker.pages.login_page import PreLoginP, LoginP
from pom.worker.pages.top_menu import TopMenuP


@pytest.fixture(scope='function')
def login_logout(get_worker_page):
    def login_as(log, passwd):
        page = PreLoginP(get_worker_page)
        page.enter_login_page().login(log, passwd)
        return page

    yield login_as

    page = TopMenuP(get_worker_page)
    page = page.logout()
    page._wait_for_visibility(page.HREF_LOGIN_L)
