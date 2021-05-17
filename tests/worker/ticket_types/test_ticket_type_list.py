from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.worker.pages.panel_page import PanelP
from pom.worker.pages.ticket_types.list_page import ActiveTicketTypesListP


def test_open_active_ticket_types_list(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/panel')
    page = PanelP(browser).open_module('Typy biletów')
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_LIST_TITLE_D, 'Lista typów biletów'))
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Typ biletu'))
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Cena'))


def test_open_deleted_ticket_types_list(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/typy-biletow')
    page = ActiveTicketTypesListP(browser).open_deleted_ticket_types_list()
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_LIST_TITLE_D, 'Lista usuniętych typów biletów'))
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Typ biletu'))
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Cena'))
