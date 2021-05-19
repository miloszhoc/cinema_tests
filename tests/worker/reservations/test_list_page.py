import pytest

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.worker.pages.film_show.list_page import ActiveFilmShowListP


def test_active_film_show_reservation_list(create_active_film_show, login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')
    show_data = create_active_film_show

    page = ActiveFilmShowListP(browser).open_film_show_details(show_data['movie_title'])

    with pytest.assume:
        assert page.is_element_on_page(page.HREF_ADD_RESERVATION_S)
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'ID'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Imię i Nazwisko'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Do zapłaty'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Opłacona'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Potwierdzona'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Data rezerwacji'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Opłacenie/Potwierdzenie'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Edycja'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Usuwanie'))


def test_archive_film_show_reservation_list(create_archived_film_show, login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')
    show_data = create_archived_film_show

    page = ActiveFilmShowListP(browser).open_archive_film_show_list().open_film_show_details(show_data['movie_title'])

    with pytest.assume:
        assert not page.is_element_on_page(page.HREF_ADD_RESERVATION_S)
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'ID'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Imię i Nazwisko'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Do zapłaty'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Opłacona'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Potwierdzona'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Data rezerwacji'))
    with pytest.assume:
        assert not page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Opłacenie/Potwierdzenie'))
    with pytest.assume:
        assert not page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Edycja'))
    with pytest.assume:
        assert not page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Usuwanie'))
