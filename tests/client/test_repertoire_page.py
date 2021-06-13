from pom.client.pages.main_page import MainP
from utils.utils import DateUtils


def test_repertoire_page(get_client_module, create_active_film_show):
    show_data = create_active_film_show
    driver = get_client_module
    page = MainP(driver)
    page = page.open_repertoire_page()
    assert page.get_page_title() == 'Repertuar'

    start_date, start_time = show_data['start_date'].replace('-', '.').split(' ')
    start_date = start_date.split('.')[2] + '.' + start_date.split('.')[1] + '.' + start_date.split('.')[0]

    end_datetime = DateUtils.count_end_time(start_date, start_time, show_data['movie_data']['duration'],
                                            show_data['break_time'])
    end_time = end_datetime.split(' ')[1]

    assert page.get_start_time(show_data['movie_data']['title']) == start_time
    assert page.get_end_time(show_data['movie_data']['title']) == end_time
