import pytest

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.base.checks import Assertions
from pom.worker.pages.ticket_types.list_page import ActiveTicketTypesListP
from utils.utils import DateUtils


def test_c62_delete_ticket_type(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/typy-biletow')
    page = ActiveTicketTypesListP(browser)

    type_name = DateUtils.add_timestamp('ticket type to delete')
    price = '33.30'
    conditions = 'test conditions'

    page = page.open_add_ticket_type_form().add_ticket_type(type_name, price, conditions, False)
    page = page.open_delete_ticket_type_page()
    with pytest.assume:
        assert page.check_ticket_type_name(type_name)
    page = page.delete_ticket_type()
    assert not Assertions.is_element_on_page(browser, page.dynamic_locator(page.HREF_TICKET_TYPE_DETAILS_D, type_name))
