import pytest

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, IMG_FILE, WORKER_PASS, WORKER_LOG
from pom.base.checks import Assertions
from pom.worker.pages.movies.list_page import ActiveMoviesListP
from utils.utils import DateUtils
from selenium.common.exceptions import TimeoutException


# todo - DRY, create movie with request

def test_c51_delete_movie(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/filmy')
    page = ActiveMoviesListP(browser)

    title = DateUtils.add_timestamp('movie_to_delete')
    director = 'test director'
    release_year = '1995'
    duration = '1:15:00'
    description = 'test description'
    link = 'https://genius.com/Rick-astley-never-gonna-give-you-up-lyrics'
    thumbnail_file_path = IMG_FILE
    youtube_id = 'dQw4w9WgXcQ'
    deleted = False
    page = page.open_add_movie_form().add_movie(title, director, release_year, description, link,
                                                thumbnail_file_path, youtube_id, deleted,
                                                duration).open_delete_movie_page()
    with pytest.assume:
        assert page.check_movie_title(title)
    page = page.delete_movie()
    assert not Assertions.is_element_on_page(browser, page.dynamic_locator(page.HREF_MOVIE_DETAILS_D, title))


def test_c52_abandon_deletion_form(login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/filmy')
    page = ActiveMoviesListP(browser)

    title = DateUtils.add_timestamp('movie_to_delete')
    director = 'test director'
    release_year = '1995'
    duration = '1:15:00'
    description = 'test description'
    link = 'https://genius.com/Rick-astley-never-gonna-give-you-up-lyrics'
    thumbnail_file_path = IMG_FILE
    youtube_id = 'dQw4w9WgXcQ'
    deleted = False
    page = page.open_add_movie_form().add_movie(title, director, release_year, description, link,
                                                thumbnail_file_path, youtube_id, deleted,
                                                duration).open_delete_movie_page()
    with pytest.assume:
        assert page.check_movie_title(title)
    page = page.exit_form_without_deletion()
    assert Assertions.check_url(browser, 'szczegoly-filmu')


# fixme may crash randomly - clicks on the first movie on the list
@pytest.mark.xfail()
def test_c53_delete_movie_user_without_privileges(login_logout):
    browser = login_logout(WORKER_LOG, WORKER_PASS, '/worker/filmy')
    page = ActiveMoviesListP(browser)
    with pytest.raises(TimeoutException):
        page.open_movie_details('').open_delete_movie_page()
