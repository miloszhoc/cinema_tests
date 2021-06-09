import pytest

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.worker.pages.ticket_types.list_page import ActiveTicketTypesListP
from utils.utils import DateUtils


def test_update_ticket_type_and_check_details(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/typy-biletow')
    page = ActiveTicketTypesListP(browser)

    type_name = DateUtils.add_timestamp('test ticket type')
    page = page.open_add_ticket_type_form().add_ticket_type(type_name, '12.30',
                                                            'test conditions', False)

    updated_type_name = DateUtils.add_timestamp('test ticket type')
    updated_price = '19.99'
    updated_conditions = 'updated conditions'
    updated_deleted = False

    page = page.open_update_ticket_type_form().add_ticket_type(updated_type_name, updated_price,
                                                               updated_conditions, updated_deleted)
    with pytest.assume:
        assert page.is_element_on_page(
            page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D, name='Typ', value=updated_type_name))
    with pytest.assume:
        assert page.is_element_on_page(
            page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D, name='Cena', value=updated_price.replace('.', ',')))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                            name='Dodatkowe informacje', value=updated_conditions))
