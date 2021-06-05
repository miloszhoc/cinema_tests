from pom.client.pages.main_page import MainP


def test_open_check_movie_details(create_active_film_show, get_client_module):
    driver = get_client_module
    film_show = create_active_film_show
    page = MainP(driver)
    page = page.open_movie_details(film_show['movie_data']['title'])
    assert page.get_field_value('Tytuł') == film_show['movie_data']['title']
    assert page.get_field_value('Reżyser') == film_show['movie_data']['director']
    assert page.get_field_value('Data premiery') == film_show['movie_data']['release_year']
    assert page.get_field_value('Czas trwania') == film_show['movie_data']['duration']
    assert page.get_field_value('Opis') == film_show['movie_data']['description']

    assert page.is_element_on_page(page.FRAME_YT_S)
    assert page.is_element_on_page(page.IMG_THUMBNAIL_S)
    assert page.get_element_attr(page.TEXT_LINK_REVIEW_S, 'href') == film_show['movie_data']['link']

    start_date, start_time = film_show['start_date'].split(' ')
    start_date = start_date.split('-')[2] + '.' + start_date.split('-')[1] + '.' + start_date.split('-')[0]
    start_datetime = start_date + ' ' + start_time
    assert page.is_element_on_page(page.dynamic_locator(page.BUTTON_RESERVATION_D, datetime=start_datetime))
