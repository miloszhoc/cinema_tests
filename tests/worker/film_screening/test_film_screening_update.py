import pytest

from env_data import STAFF_ADMIN_LOG, STAFF_ADMIN_PASS
from pom.worker.pages.film_show.list_page import ActiveFilmShowListP
from utils.mail import Email


@pytest.mark.email
def test_c22_update_film_show(delete_film_show_with_reservation, login_logout):
    data = delete_film_show_with_reservation
    browser = login_logout(STAFF_ADMIN_LOG, STAFF_ADMIN_PASS, '/worker/seanse')

    page = ActiveFilmShowListP(browser).open_film_show_details(data['movie_title'])
    page = page.open_update_film_show_form()._click_save_button()

    e = Email()
    email_content = e.wait_open_email('Aktualizacja seansu')

    assert data['movie_title'] in email_content
    assert 'Seans został pomyślnie zaktualizowany. Wysłano wiadomiści z informacją do klientów.' in page.get_message()
