from pom.client.pages.main_page import MainP
from pom.base.checks import Assertions


def test_c80_open_reservation_form_from_movie_details(create_active_film_show, get_client_module):
    driver = get_client_module
    film_show = create_active_film_show
    page = MainP(driver)
    page = page.open_movie_details(film_show['movie_data']['title'])

    page = page.open_reservation_form(film_show['start_date'])
    assert Assertions.check_url(driver, 'rezerwuj-miejsce')


def test_c79_open_reservation_form_from_repertoire_page(create_active_film_show, get_client_module):
    driver = get_client_module
    film_show = create_active_film_show
    page = MainP(driver)
    page = page.open_repertoire_page()
    page = page.open_reservation_form(film_show['movie_data']['title'])

    assert Assertions.check_url(driver, 'rezerwuj-miejsce')
