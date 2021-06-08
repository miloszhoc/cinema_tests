from pom.client.pages.main_page import MainP


def test_open_reservation_form_from_movie_details(create_active_film_show, get_client_module):
    driver = get_client_module
    film_show = create_active_film_show
    page = MainP(driver)
    page = page.open_movie_details(film_show['movie_data']['title'])

    page = page.open_reservation_form(film_show['start_date'])
    assert page.check_url('rezerwuj-miejsce')


def test_open_reservation_form_from_repertoire_page(create_active_film_show, get_client_module):
    driver = get_client_module
    film_show = create_active_film_show
    page = MainP(driver)
    page = page.open_repertoire_page()
    page = page.open_reservation_form(film_show['movie_data']['title'])

    assert page.check_url('rezerwuj-miejsce')
