import pytest
import requests
from selenium.common.exceptions import NoSuchElementException

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, APP_URL
from pom.worker.pages.film_show.list_page import ActiveFilmShowListP


def test_c40_mark_reservation_as_paid_and_confirmed_in_active_film_show(delete_film_show_with_reservation, login_logout):
    data = delete_film_show_with_reservation
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')
    page = ActiveFilmShowListP(browser).open_film_show_details(data['movie_title'])
    page = page.reservation_list.open_pay_confirm_form(data['first_name']).mark_reservation(paid=True, confirmed=True)
    assert page.get_text(
        page.dynamic_locator(page.reservation_list.TEXT_RESERVATION_PAID_D, person_name=data['first_name'])) == 'Tak'
    assert page.get_text(page.dynamic_locator(page.reservation_list.TEXT_RESERVATION_CONFIRMED_D,
                                              person_name=data['first_name'])) == 'Tak'


def test_c35_update_reservation_active_film_show(create_film_show_with_reservation, login_logout):
    data = create_film_show_with_reservation
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')
    first_name = data['first_name']

    page = ActiveFilmShowListP(browser).open_film_show_details(data['movie_title'])
    page = page.reservation_list.open_update_reservation_page(data['first_name'])

    page.add_tickets('2')

    seats = ['A1', 'B2']
    for i in range(len(seats)):
        page.select_seat_and_ticket_type(i + 1, seats[i], data['ticket_type_name'])
    page._click_paid_checkbox()
    page._click_confirmed_checkbox()

    page = page.click_send_update_form_button()

    assert page.get_text(
        page.dynamic_locator(page.reservation_list.TEXT_RESERVATION_PAID_D, person_name=data['first_name'])) == 'Tak'
    assert page.get_text(page.dynamic_locator(page.reservation_list.TEXT_RESERVATION_CONFIRMED_D,
                                              person_name=data['first_name'])) == 'Tak'

    for seat in seats:
        with pytest.assume:
            assert page.reservation_list.check_reservation_details(first_name, 'Miejsce', seat[1] + '' + seat[0])
        with pytest.assume:
            assert page.reservation_list.check_reservation_details(first_name, 'Miejsce', data['ticket_type_name'])

    assert 'Rezerwacja została pomyślnie zaktualizowana. Nie została zaznaczona opcja wysyłki wiadomości email do klienta.' \
           in page.get_message()


def test_c38_choose_taken_seat_in_update_reservation_form(delete_film_show_with_reservation, login_logout):
    data = delete_film_show_with_reservation
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')

    page = ActiveFilmShowListP(browser).open_film_show_details(data['movie_title'])
    page = page.reservation_list.open_update_reservation_page(data['first_name'])

    with pytest.raises(NoSuchElementException):
        page.select_seat_and_ticket_type(1, 'B1', data['ticket_type_name'])


@pytest.mark.production
def test_c45_trigger_automatic_reservation_deletion():
    r = requests.get(APP_URL + '/worker/cron/usun-rezerwacje')
    assert r.status_code == 200
    keys = r.json().keys()
    assert 'deleted_reservations' in keys
    assert 'deleted_tickets' in keys
    assert 'errors' in keys
