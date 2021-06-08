import pytest

from env_data import EMAIL_LOGIN
from pom.client.pages.main_page import MainP
from utils.mail import Email
from utils.utils import DateUtils


@pytest.mark.email
def test_add_client_valid_reservation(create_active_film_show, create_ticket_type, get_client_module):
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

    assert page.check_summary('Seans', show_data['movie_title'])
    assert page.check_summary('Imię', name)
    assert page.check_summary('Nazwisko', last_name)
    assert page.check_summary('Email', email)
    assert page.check_summary('Numer telefonu', number)

    page = page.fill_out_second_tab(seat, ticket_type['name'])

    assert page.check_summary('Seans', show_data['movie_title'])
    assert page.check_summary('Imię', name)
    assert page.check_summary('Nazwisko', last_name)
    assert page.check_summary('Email', email)
    assert page.check_summary('Numer telefonu', number)

    assert page.check_ticket_type(seat, ticket_type['name'])

    ticket_price = float(ticket_type['price'])
    assert page.check_total_price(str(ticket_price))

    page = page.send_reservation()
    assert 'Rezerwacja została pomyślnie utworzona, na twój adres mailowy została wysłana wiadomość z potwierdzeniem. Jeśli nie potwierdzisz rezerwacji w ciągu 30 minut, to zostanie ona automatycznie usunięta z systemu. W przypadku braku otrzymania wiadomości email prosimy o pilny kontakt telefoniczny.' \
           in page.get_message()

    e = Email()
    email_content = e.wait_open_email('Potwierdzenie rezerwacji')

    assert '/potwierdz/' in email_content
    assert '/anuluj/' in email_content


def test_add_client_invalid_reservation_more_than_10_seats(create_active_film_show, get_client_module):
    driver = get_client_module
    show_data = create_active_film_show

    page = MainP(driver)
    page = page.open_movie_details(show_data['movie_data']['title'])

    page = page.open_reservation_form(show_data['start_date'])
    name = DateUtils().add_timestamp('John')
    last_name = 'Test'
    number = '789456123'
    email = EMAIL_LOGIN
    seats = ['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'B1', 'B2', 'B3', 'B4', 'B5']
    page._type_name(name)
    page._type_last_name(last_name)
    page._type_email(email)
    page._type_phone_number(number)
    for seat in seats:
        page._choose_seat(seat)
    page._click_next_button()
    assert 'Możesz zarezerwować maksymalnie 10 miejsc! W celu rezerwacji większej ilości miejsc skontaktuj się z pracownikiem kina.' \
           in page.get_message()
