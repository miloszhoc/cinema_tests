import pytest

from pom.client.pages.main_page import MainP


@pytest.mark.production
def test_about_page(get_client_module):
    driver = get_client_module
    page = MainP(driver)
    page = page.open_about_page()
    assert page.get_page_title() == 'O kinie'
    assert page.get_number_of_cards() == 3
