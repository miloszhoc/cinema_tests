import pytest
from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, ADMIN_LOG, ADMIN_PASS, WORKER_LOG, WORKER_PASS
from pom.worker.pages.login_page import PreLoginP


def test_login_as_staff_admin(get_worker_page):
    driver = get_worker_page
    page = PreLoginP(driver)
    page = page.enter_login_page().login(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS)
    with pytest.assume:
        assert STAFF_ADMIN_LOG in page.get_text(page.TEXT_USERNAME_L)
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.HREF_MODULE_L_D, 'Zarządzanie użytkownikami'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.HREF_MODULE_L_D, 'Seanse'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.HREF_MODULE_L_D, 'Filmy'))
    with pytest.assume:
        assert not page.is_element_on_page(page.dynamic_locator(page.HREF_MODULE_L_D, 'Typy biletów'))
    page.logout()

# def test_login_as_admin(login_logout):
#     pass
#
#
# def test_login_as_worker(login_logout):
#     pass
