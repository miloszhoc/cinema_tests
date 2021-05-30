import pytest
from selenium.common.exceptions import TimeoutException

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.worker.pages.film_show.list_page import ActiveFilmShowListP


def test_delete_film_show(create_film_show_with_reservation, login_logout):
    data = create_film_show_with_reservation
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')

    page = ActiveFilmShowListP(browser).open_film_show_details(data['movie_title'])
    page = page.open_delete_film_show_page().delete_film_show()
    with pytest.raises(TimeoutException):
        page.open_film_show_details(data['movie_title'])
