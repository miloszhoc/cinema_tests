from pom.client.pages.main_page import MainP


def test_price_list_page_active_ticket_type(create_ticket_type, get_client_module):
    driver = get_client_module
    ticket_type = create_ticket_type
    page = MainP(driver)
    page = page.open_price_list_page()

    assert page.get_page_title() == 'Cennik'
    assert 'Typ' in page.get_column_names()
    assert 'Cena' in page.get_column_names()

    assert page.check_ticket_type_details(ticket_type['name'], ticket_type['description'])
    assert page.check_data_in_table(ticket_type['name'], ticket_type['price'])


def test_price_list_page_inactive_ticket_type(create_inactive_ticket_type, get_client_module):
    driver = get_client_module
    ticket_type = create_inactive_ticket_type
    page = MainP(driver)
    page = page.open_price_list_page()

    assert not page.check_ticket_type_details(ticket_type['name'], ticket_type['description'])
    assert not page.check_data_in_table(ticket_type['name'], ticket_type['price'])
