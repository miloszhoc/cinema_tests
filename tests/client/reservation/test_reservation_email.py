import re

import pytest
from selenium.common.exceptions import TimeoutException

from env_data import EMAIL_LOGIN, APP_URL, STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.client.pages.main_page import MainP
from pom.client.pages.reservation.confirmation_page import ConfirmationP
from pom.client.pages.reservation.rejection_page import RejectionP
from pom.worker.pages.login_page import LoginP
from utils.mail import Email
from utils.utils import DateUtils


@pytest.mark.email
def test_c85_client_confirm_reservation(create_active_film_show, create_ticket_type, get_client_module):
    driver = get_client_module
    show_data = create_active_film_show
    ticket_type = create_ticket_type

    page = MainP(driver)
    page = page.open_movie_details(show_data['movie_data']['title'])

    page = page.open_reservation_form(show_data['start_date'])
    name = DateUtils().add_timestamp('John')
    last_name = 'Client'
    number = '789456123'
    email = EMAIL_LOGIN
    seat = 'A1'
    page = page.fill_out_first_tab(name, last_name, email, number, 'A1')

    page = page.fill_out_second_tab(seat, ticket_type['name'])

    page = page.send_reservation()
    assert 'Rezerwacja została pomyślnie utworzona, na twój adres mailowy została wysłana wiadomość z potwierdzeniem. Jeśli nie potwierdzisz rezerwacji w ciągu 30 minut, to zostanie ona automatycznie usunięta z systemu. W przypadku braku otrzymania wiadomości email prosimy o pilny kontakt telefoniczny.' \
           in page.get_message()

    e = Email()
    email_content = e.wait_open_email('Potwierdzenie rezerwacji na seans ' + show_data['movie_data']['title'])
    confirm_url = APP_URL + re.findall('/potwierdz.*', email_content)[0]

    driver.get(confirm_url)
    page = ConfirmationP(driver)
    page = page.confirm_reservation()

    assert 'Rezerwacja została pomyślnie potwierdzona.' in page.get_message()

    driver.get(APP_URL + '/worker/login/')
    page = LoginP(driver)
    page.login(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS)
    driver.get(APP_URL + '/worker/szczegoly-seansu/{}'.format(show_data['film_show_id']))

    from pom.worker.pages.film_show.film_show_details import FilmShowDetailsP

    page = FilmShowDetailsP(driver)
    assert page.get_text(page.dynamic_locator(page.reservation_list.TEXT_RESERVATION_CONFIRMED_D, person_name=name)) == 'Tak'


@pytest.mark.email
def test_c86_client_reject_reservation(create_active_film_show, create_ticket_type, get_client_module):
    driver = get_client_module
    show_data = create_active_film_show
    ticket_type = create_ticket_type

    page = MainP(driver)
    page = page.open_movie_details(show_data['movie_data']['title'])

    page = page.open_reservation_form(show_data['start_date'])
    name = DateUtils().add_timestamp('John')
    last_name = 'Client'
    number = '789456123'
    email = EMAIL_LOGIN
    seat = 'A1'
    page = page.fill_out_first_tab(name, last_name, email, number, 'A1')

    page = page.fill_out_second_tab(seat, ticket_type['name'])

    page = page.send_reservation()
    assert 'Rezerwacja została pomyślnie utworzona, na twój adres mailowy została wysłana wiadomość z potwierdzeniem. Jeśli nie potwierdzisz rezerwacji w ciągu 30 minut, to zostanie ona automatycznie usunięta z systemu. W przypadku braku otrzymania wiadomości email prosimy o pilny kontakt telefoniczny.' \
           in page.get_message()

    e = Email()
    email_content = e.wait_open_email('Potwierdzenie rezerwacji na seans ' + show_data['movie_data']['title'])
    reject_url = APP_URL + re.findall('/anuluj.*', email_content)[0]

    driver.get(reject_url)

    page = RejectionP(driver)
    page = page.reject_reservation()

    assert 'Rezerwacja została pomyślnie usunięta.' in page.get_message()

    driver.get(APP_URL + '/worker/login/')
    page = LoginP(driver)
    page.login(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS)
    driver.get(APP_URL + '/worker/szczegoly-seansu/{}'.format(show_data['film_show_id']))

    from pom.worker.pages.film_show.film_show_details import FilmShowDetailsP

    page = FilmShowDetailsP(driver)
    with pytest.raises(TimeoutException):
        page.reservation_list.open_reservation_details(name)
