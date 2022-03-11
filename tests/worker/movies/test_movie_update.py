import os

import pytest

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, IMG_FILE
from pom.base.checks import Assertions
from pom.worker.pages.movies.list_page import ActiveMoviesListP
from utils.utils import DateUtils


# todo - DRY, create movie with request
def test_c50_update_movie_and_check_details(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/filmy')
    page = ActiveMoviesListP(browser)

    title = DateUtils.add_timestamp('test movie')

    page = page.open_add_movie_form().add_movie(title, 'test director', '1995', 'test description',
                                                'https://genius.com/Rick-astley-never-gonna-give-you-up-lyrics',
                                                IMG_FILE, 'dQw4w9WgXcQ', False, '1:15:00')

    with pytest.assume:
        assert Assertions.check_url(browser, 'szczegoly-filmu')

    updated_title = DateUtils.add_timestamp('test movie')
    updated_director = 'updated director'
    updated_release_year = '2000'
    updated_duration = '2:35:00'
    updated_description = 'updated_description'
    updated_link = 'https://genius.com/updated-link'
    updated_thumbnail_file_path = IMG_FILE
    updated_youtube_id = 'dQw4w9WgXcaaaaa'
    updated_deleted = True
    page = page.open_update_movie_form().add_movie(updated_title, updated_director, updated_release_year,
                                                   updated_description, updated_link,
                                                   updated_thumbnail_file_path, updated_youtube_id, updated_deleted,
                                                   updated_duration)
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D, name='Tytuł',
                                                                           value=updated_title))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D, name='Reżyser',
                                                                           value=updated_director))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                                           name='Data premiery',
                                                                           value=updated_release_year))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                                           name='Czas trwania', value=updated_duration))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                                           name='Opis', value=updated_description))
    with pytest.assume:
        assert updated_youtube_id in page.get_element_attr(page.FRAME_YT_S, 'src')
    with pytest.assume:
        assert updated_thumbnail_file_path.split(os.path.sep)[-1].split('.')[0] in page.get_element_attr(
            page.IMG_THUMBNAIL_S,
            'src')
