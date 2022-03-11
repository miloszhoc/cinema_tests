import pytest
from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, ADMIN_LOG, ADMIN_PASS, WORKER_LOG, WORKER_PASS
from pom.base.checks import Assertions
from pom.worker.pages.login_page import PreLoginP


@pytest.mark.production
def test_c2_login_as_staff_admin(get_worker_module):
    driver = get_worker_module
    page = PreLoginP(driver)
    page = page.enter_login_page().login(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS)
    with pytest.assume:
        assert STAFF_ADMIN_LOG in page.get_text(page.TEXT_USERNAME_S)
    with pytest.assume:
        assert Assertions.is_element_on_page(driver,
                                             page.dynamic_locator(page.HREF_MODULE_D, 'Zarządzanie użytkownikami'))
    with pytest.assume:
        assert Assertions.is_element_on_page(driver, page.dynamic_locator(page.HREF_MODULE_D, 'Seanse'))
    with pytest.assume:
        assert Assertions.is_element_on_page(driver, page.dynamic_locator(page.HREF_MODULE_D, 'Filmy'))
    with pytest.assume:
        assert Assertions.is_element_on_page(driver, page.dynamic_locator(page.HREF_MODULE_D, 'Typy biletów'))
    page.logout()


@pytest.mark.production
def test_c1_login_as_admin(get_worker_module):
    driver = get_worker_module
    page = PreLoginP(driver)
    page = page.enter_login_page().login(ADMIN_LOG, ADMIN_PASS)
    with pytest.assume:
        assert ADMIN_LOG in page.get_text(page.TEXT_USERNAME_S)
    with pytest.assume:
        assert not Assertions.is_element_on_page(driver,
                                                 page.dynamic_locator(page.HREF_MODULE_D, 'Zarządzanie użytkownikami'))
    with pytest.assume:
        assert Assertions.is_element_on_page(driver, page.dynamic_locator(page.HREF_MODULE_D, 'Seanse'))
    with pytest.assume:
        assert Assertions.is_element_on_page(driver, page.dynamic_locator(page.HREF_MODULE_D, 'Filmy'))
    with pytest.assume:
        assert Assertions.is_element_on_page(driver, page.dynamic_locator(page.HREF_MODULE_D, 'Typy biletów'))
    page.logout()


@pytest.mark.production
def test_c3_login_as_worker(get_worker_module):
    driver = get_worker_module
    page = PreLoginP(driver)
    page = page.enter_login_page().login(WORKER_LOG, WORKER_PASS)
    with pytest.assume:
        assert WORKER_LOG in page.get_text(page.TEXT_USERNAME_S)
    with pytest.assume:
        assert not Assertions.is_element_on_page(driver,
                                                 page.dynamic_locator(page.HREF_MODULE_D, 'Zarządzanie użytkownikami'))
    with pytest.assume:
        assert Assertions.is_element_on_page(driver, page.dynamic_locator(page.HREF_MODULE_D, 'Seanse'))
    with pytest.assume:
        assert Assertions.is_element_on_page(driver, page.dynamic_locator(page.HREF_MODULE_D, 'Filmy'))
    with pytest.assume:
        assert Assertions.is_element_on_page(driver, page.dynamic_locator(page.HREF_MODULE_D, 'Typy biletów'))
    page.logout()


@pytest.mark.production
def test_c4_login_invalid_credentials(get_worker_module):
    driver = get_worker_module
    page = PreLoginP(driver)
    page.enter_login_page().login('test', 'test')

    assert Assertions.is_element_on_page(driver, page.dynamic_locator(page.TEXT_ELEMENT_D,
                                                                      'Wprowadź poprawne wartości pól użytkownik oraz hasło. Uwaga: wielkość liter ma znaczenie.'))
