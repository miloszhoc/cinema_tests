import os
import pytest

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, IMG_FILE
from pom.base.checks import Assertions
from pom.worker.pages.movies.list_page import ActiveMoviesListP
from utils.utils import DateUtils


@pytest.mark.parametrize('is_deleted', [True, False])
def test_c48_add_movie_and_check_details(login_logout, is_deleted):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/filmy')
    page = ActiveMoviesListP(browser)

    title = DateUtils.add_timestamp('test movie')
    director = 'test director'
    release_year = '1995'
    duration = '1:15:00'
    description = 'test description'
    link = 'https://genius.com/Rick-astley-never-gonna-give-you-up-lyrics'
    thumbnail_file_path = IMG_FILE
    youtube_id = 'dQw4w9WgXcQ'

    if is_deleted:
        deleted = True
    else:
        deleted = False

    page = page.open_add_movie_form().add_movie(title, director, release_year, description, link,
                                                thumbnail_file_path, youtube_id, deleted, duration)

    with pytest.assume:
        assert Assertions.check_url(browser, 'szczegoly-filmu')

    page = page.open_panel_page().open_module('Filmy')
    if not is_deleted:
        Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_DELETED_COLUMN_VALUE_D, title=title,
                                                                    deleted='Nie'))
        page = page.open_movie_details(title)
    else:
        page = page.open_deleted_movies_list()
        Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_DELETED_COLUMN_VALUE_D, title=title,
                                                                    deleted='Tak'))
        page = page.open_movie_details(title)

    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D, name='Tytuł',
                                                                           value=title))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D, name='Reżyser',
                                                                           value=director))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                                           name='Data premiery', value=release_year))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                                           name='Czas trwania', value=duration))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                                           name='Opis', value=description))
    with pytest.assume:
        assert youtube_id in page.get_element_attr(page.FRAME_YT_S, 'src')
    with pytest.assume:
        assert thumbnail_file_path.split(os.path.sep)[-1].split('.')[0] in page.get_element_attr(page.IMG_THUMBNAIL_S,
                                                                                                 'src')
