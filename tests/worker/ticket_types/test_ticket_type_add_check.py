import pytest

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.base.checks import Assertions
from pom.worker.pages.ticket_types.list_page import ActiveTicketTypesListP
from utils.utils import DateUtils


@pytest.mark.parametrize('is_deleted', [True, False])
def test_c58_add_ticket_type_and_check_details(login_logout, is_deleted):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/typy-biletow')
    page = ActiveTicketTypesListP(browser)

    type_name = DateUtils.add_timestamp('test ticket type')
    price = '12.30'
    conditions = 'test conditions'

    if is_deleted:
        deleted = True
    else:
        deleted = False

    page = page.open_add_ticket_type_form().add_ticket_type(type_name, price, conditions, deleted)

    with pytest.assume:
        assert Assertions.check_url(browser, 'szczegoly-typu')

    if is_deleted:
        page = page.open_panel_page().open_module(
            'Typy biletów').open_deleted_ticket_types_list().open_ticket_type_details(type_name)

    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D, name='Typ',
                                                                           value=type_name))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D, name='Cena',
                                                                           value=price.replace('.', ',')))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                                           name='Dodatkowe informacje',
                                                                           value=conditions))
