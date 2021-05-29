import pytest
from selenium.common.exceptions import TimeoutException

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, EMAIL_LOGIN
from pom.worker.pages.film_show.list_page import ActiveFilmShowListP

from utils.mail import Email
from utils.utils import DateUtils


@pytest.mark.email
def test_add_check_reservation_in_active_film_show(create_active_film_show, create_ticket_type, login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')
    show_data = create_active_film_show
    ticket_type = create_ticket_type

    page = ActiveFilmShowListP(browser).open_film_show_details(show_data['movie_title'])
    page = page.open_add_reservation_form()
    name = DateUtils().add_timestamp('John')
    last_name = 'Test'
    number = '789456123'
    email = EMAIL_LOGIN
    seats = ['A1', 'C2']
    page._type_name(name)
    page._type_last_name(last_name)
    page._type_email(email)
    page._type_phone_number(number)
    for seat in seats:
        page._choose_seat(seat)
    page = page._click_next_button()

    assert page.check_summary('Seans', show_data['movie_title'])
    assert page.check_summary('Imię', name)
    assert page.check_summary('Nazwisko', last_name)
    assert page.check_summary('Email', email)
    assert page.check_summary('Numer telefonu', number)

    for seat in seats:
        page._choose_ticket_type(seat, ticket_type['name'])
    page = page._click_next_button()

    assert page.check_summary('Seans', show_data['movie_title'])
    assert page.check_summary('Imię', name)
    assert page.check_summary('Nazwisko', last_name)
    assert page.check_summary('Email', email)
    assert page.check_summary('Numer telefonu', number)

    for seat in seats:
        assert page.check_ticket_type(seat, ticket_type['name'])

    ticket_price = float(ticket_type['price'])
    total_price = 0
    for seat in seats:
        total_price += ticket_price

    page._click_confirmation_email_checkbox()
    assert page.check_total_price(str(total_price))

    page = page._send_reservation()
    assert page.check_message(
        'Rezerwacja została pomyślnie utworzona, na adres mailowy klienta została wysłana wiadomość z potwierdzeniem. Jeśli klient nie potwierdzi rezerwacji w ciągu 30 minut, to zostanie ona usunięta z systemu')

    e = Email()
    email_content = e.wait_open_email('Potwierdzenie rezerwacji')

    assert '/potwierdz/' in email_content
    assert '/anuluj/' in email_content

    full_name = name + ' ' + last_name
    page.open_reservation_details(full_name)

    for seat in seats:
        with pytest.assume:
            assert page.check_reservation_details(full_name, 'Miejsce', seat[1] + '' + seat[0])
        with pytest.assume:
            assert page.check_reservation_details(full_name, 'Miejsce', ticket_type['name'])
        with pytest.assume:
            assert page.check_reservation_details(full_name, 'Miejsce', str(ticket_price).replace('.', ','))
    with pytest.assume:
        assert page.check_reservation_details(full_name, 'Email', email)
    with pytest.assume:
        assert page.check_reservation_details(full_name, 'Telefon', number)


def test_add_reservation_to_archive_film_show(create_archived_film_show, login_logout):
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')
    show_data = create_archived_film_show

    page = ActiveFilmShowListP(browser).open_film_show_details(show_data['movie_title'])
    with pytest.raises(TimeoutException):
        page.open_add_reservation_form()
