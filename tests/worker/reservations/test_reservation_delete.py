import pytest
from selenium.common.exceptions import TimeoutException

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.worker.pages.film_show.list_page import ActiveFilmShowListP


def test_c42_delete_reservation_active_film_show(create_film_show_with_reservation, login_logout):
    data = create_film_show_with_reservation
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')

    page = ActiveFilmShowListP(browser).open_film_show_details(data['movie_title'])
    page = page.reservation_list.open_delete_reservation_page(data['first_name']).delete_reservation()

    assert 'Rezerwacja została pomyślnie usunięta.' in page.get_message()

    with pytest.raises(TimeoutException):
        page.reservation_list.open_reservation_details(data['first_name'])
