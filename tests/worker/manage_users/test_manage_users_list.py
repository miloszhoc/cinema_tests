import pytest

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.worker.pages.panel_page import PanelP


def test_check_manage_users_module(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/panel/')
    page = PanelP(browser)
    page = page.open_module('Zarządzanie użytkownikami')
    with pytest.assume:
        page.is_element_on_page(page.HREF_MODEL_USERS_S)

    with pytest.assume:
        page.is_element_on_page(page.dynamic_locator(page.HREF_TOP_MENU_D, 'POKAŻ STRONĘ'))

    with pytest.assume:
        page.is_element_on_page(page.dynamic_locator(page.HREF_TOP_MENU_D, 'ZMIANA HASŁA'))

    with pytest.assume:
        page.is_element_on_page(page.dynamic_locator(page.HREF_TOP_MENU_D, 'WYLOGUJ SIĘ'))

    with pytest.assume:
        page.is_element_on_page(page.DIV_LAST_ACTIONS_S)

    with pytest.assume:
        page.is_element_on_page(page.HREF_MODEL_USERS_S)
