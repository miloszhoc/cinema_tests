import pytest

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.base.checks import Assertions
from pom.worker.pages.film_show.list_page import ActiveFilmShowListP


def test_c24_active_film_show_reservation_list(create_active_film_show, login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')
    show_data = create_active_film_show

    page = ActiveFilmShowListP(browser).open_film_show_details(show_data['movie_title'])

    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.reservation_list.HREF_ADD_RESERVATION_S)
    with pytest.assume:
        assert Assertions.is_element_on_page(browser,
                                             page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D, 'ID'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Imię i Nazwisko'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Do zapłaty'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Opłacona'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Potwierdzona'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Data rezerwacji'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Opłacenie/Potwierdzenie'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser,
                                             page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D, 'Edycja'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Usuwanie'))


def test_c25_archive_film_show_reservation_list(create_archived_film_show, login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')
    show_data = create_archived_film_show

    page = ActiveFilmShowListP(browser).open_archive_film_show_list().open_film_show_details(show_data['movie_title'])

    with pytest.assume:
        assert not Assertions.is_element_on_page(browser, page.reservation_list.HREF_ADD_RESERVATION_S)
    with pytest.assume:
        assert Assertions.is_element_on_page(browser,
                                             page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D, 'ID'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Imię i Nazwisko'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Do zapłaty'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Opłacona'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Potwierdzona'))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                           'Data rezerwacji'))
    with pytest.assume:
        assert not Assertions.is_element_on_page(browser,
                                                 page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                      'Opłacenie/Potwierdzenie'))
    with pytest.assume:
        assert not Assertions.is_element_on_page(browser,
                                                 page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                      'Edycja'))
    with pytest.assume:
        assert not Assertions.is_element_on_page(browser,
                                                 page.dynamic_locator(page.reservation_list.TEXT_TABLE_HEADER_D,
                                                                      'Usuwanie'))
