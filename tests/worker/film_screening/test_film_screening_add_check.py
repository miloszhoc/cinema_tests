import pytest

from env_data import STAFF_ADMIN_PASS, STAFF_ADMIN_LOG
from pom.base.checks import Assertions
from pom.worker.pages.film_show.list_page import ActiveFilmShowListP
from utils.utils import DateUtils


def test_add_film_show_and_check_details(create_movie, login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse/')
    movie_data = create_movie

    movie_title = movie_data['title']
    start_datetime = DateUtils.get_current_datetime(minutes=15)
    break_time = '00:15:00'

    page = ActiveFilmShowListP(browser)
    page = page.open_add_film_show_form().add_film_show(movie_title, start_datetime, break_time)

    with pytest.assume:
        assert Assertions.check_url(browser, 'szczegoly-seansu')

    page = page.open_panel_page().open_module('Seanse').open_film_show_details(movie_title)
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                                           name='Tytuł filmu', value=movie_title))

    start_date, start_time = start_datetime.replace('-', '.').split(' ')
    start_date = start_date.split('.')[2] + '.' + start_date.split('.')[1] + '.' + start_date.split('.')[0]
    start_datetime = start_date + 'r. ' + start_time

    end_datetime = DateUtils.count_end_time(start_date, start_time, movie_data['duration'], break_time)
    end_date = end_datetime.split(' ')[0]
    end_time = end_datetime.split(' ')[1]
    end_datetime = end_date + 'r. ' + end_time

    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                                           name='Data seansu', value=start_datetime))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                                           name='Data seansu', value=end_datetime))
    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.dynamic_locator(page.TEXT_FIELD_NAME_VALUE_D,
                                                                           name='Czas trwania',
                                                                           value=movie_data['duration']))

    with pytest.assume:
        assert Assertions.is_element_on_page(browser, page.reservation_list.HREF_ADD_RESERVATION_S)
