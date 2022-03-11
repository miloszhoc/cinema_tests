import pytest

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.base.checks import Assertions
from pom.worker.pages.panel_page import PanelP
from pom.worker.pages.ticket_types.list_page import ActiveTicketTypesListP


@pytest.mark.production
def test_c56_open_active_ticket_types_list(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/panel')
    page = PanelP(browser).open_module('Typy biletów')
    assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_LIST_TITLE_D, 'Lista typów biletów'))
    assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Typ biletu'))
    assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Cena'))


@pytest.mark.production
def test_c57_open_deleted_ticket_types_list(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/typy-biletow')
    page = ActiveTicketTypesListP(browser).open_deleted_ticket_types_list()
    assert Assertions.is_element_on_page(browser,
                                         page.dynamic_locator(page.TEXT_LIST_TITLE_D, 'Lista usuniętych typów biletów'))
    assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Typ biletu'))
    assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Cena'))
