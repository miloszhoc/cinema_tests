import pytest
from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.worker.pages.film_show.list_page import ActiveFilmShowListP


@pytest.mark.production
def test_active_film_screening_list(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')
    page = ActiveFilmShowListP(browser)
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_LIST_TITLE_D, 'Lista seansów'))
    with pytest.assume:
        assert page.is_element_on_page(page.HREF_ADD_SHOW_S)
    with pytest.assume:
        assert page.is_element_on_page(page.HREF_ARCHIVE_SHOW_S)
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Tytuł seansu'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Data rozpoczęcia'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Data Zakończenia'))


@pytest.mark.production
def test_archive_film_screening_list(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')
    page = ActiveFilmShowListP(browser).open_archive_film_show_list()
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_LIST_TITLE_D, 'Lista archiwalnych seansów'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Tytuł seansu'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Data rozpoczęcia'))
    with pytest.assume:
        assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Data Zakończenia'))
