from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.worker.pages.panel_page import PanelP
from pom.worker.pages.movies.list_page import ActiveMoviesListP


def test_open_active_movies_list(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/panel')
    page = PanelP(browser).open_module('Filmy')
    assert page.is_element_on_page(page.HREF_ADD_MOVIE_S)
    assert page.is_element_on_page(page.HREF_DELETED_MOVIES_S)
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_LIST_TITLE_D, 'Lista filmów'))
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Tytuł filmu'))
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Usunięty'))


def test_open_deleted_movies_list(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/filmy')
    page = ActiveMoviesListP(browser).open_deleted_movies_list()
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_LIST_TITLE_D, 'Lista usuniętych filmów'))
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Tytuł filmu'))
    assert page.is_element_on_page(page.dynamic_locator(page.TEXT_TABLE_HEADER_D, 'Usunięty'))
