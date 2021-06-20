import pytest

from pom.client.pages.main_page import MainP


@pytest.mark.production
def test_contact_page(get_client_module):
    driver = get_client_module
    page = MainP(driver)
    page = page.open_contact_page()
    assert page.get_page_title() == 'Kontakt'
    assert page.is_element_on_page(page.DIV_CARD_S)
