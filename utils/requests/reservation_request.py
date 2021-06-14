from bs4 import BeautifulSoup

from env_data import APP_URL
from utils.requests.common_request import CommonRequest


class CreateReservation(CommonRequest):
    def __save_first_tab(self, film_show_id: int, first_name: str, last_name: str,
                         email: str, phone_number: str, paid: bool, confirmed: bool, confirmation_email: bool,
                         seat_id_b_row: str) -> dict:
        page_source = self.session.get(APP_URL + '/worker/dodaj-rezerwacje/{}'.format(film_show_id)).text
        csrf_reservation = BeautifulSoup(page_source, 'html.parser').find('input',
                                                                          {'name': "csrfmiddlewaretoken"}).get('value')

        data = {'csrfmiddlewaretoken': csrf_reservation,
                'first_name': first_name,
                'last_name': last_name,
                'email': email,
                'phone_number': phone_number,
                'showtime_id': film_show_id,
                'paid': 'True' if paid else 'False',
                'confirmed': 'True' if confirmed else 'False',
                'confirmation_email': 'True' if confirmation_email else 'False',
                'seats_row_b': seat_id_b_row}

        self.session.post(APP_URL + '/worker/dodaj-rezerwacje/{}'.format(film_show_id), data=data)
        return data

    def __save_second_tab(self, film_show_id: int, first_name: str, last_name: str,
                          email: str, phone_number: str, paid: bool, confirmed: bool, confirmation_email: bool,
                          seat_id_b_row: str, ticket_type_id: str) -> dict:
        page_source = self.session.get(APP_URL + r'/worker/bilety/').text
        csrf_reservation = BeautifulSoup(page_source, 'html.parser').find('input',
                                                                          {'name': "csrfmiddlewaretoken"}).get('value')

        data = {'csrfmiddlewaretoken': csrf_reservation,
                'form-0-seat_id': seat_id_b_row,
                'form-0-tickettype_id': ticket_type_id,
                'form-TOTAL_FORMS': '1',
                'form-INITIAL_FORMS': '0',
                'form-MIN_NUM_FORMS': '0',
                'form-MAX_NUM_FORMS': '60',
                'form-0-ticket_id': '',
                'first_name': first_name,
                'last_name': last_name,
                'email': email,
                'phone_number': phone_number,
                'showtime_id': film_show_id,
                'paid': 'True' if paid else 'False',
                'confirmed': 'True' if confirmed else 'False',
                'confirmation_email': 'True' if confirmation_email else 'False'}

        self.session.post(APP_URL + '/worker/bilety/', data=data)
        return data

    def __save_third_tab_send_reservation(self, film_show_id: int, first_name: str, last_name: str,
                                          email: str, phone_number: str, paid: bool, confirmed: bool,
                                          confirmation_email: bool,
                                          seat_id_b_row: str, ticket_type_id: str) -> dict:
        page_source = self.session.get(APP_URL + r'/worker/podsumowanie/').text
        csrf_reservation = BeautifulSoup(page_source, 'html.parser').find('input',
                                                                          {'name': "csrfmiddlewaretoken"}).get('value')
        data = {'csrfmiddlewaretoken': csrf_reservation,
                'form-0-seat_id': seat_id_b_row,
                'form-0-tickettype_id': ticket_type_id,
                'form-0-ticket_id': '',
                'form-TOTAL_FORMS': '1',
                'form-INITIAL_FORMS': '0',
                'form-MIN_NUM_FORMS': '0',
                'form-MAX_NUM_FORMS': '60',
                'first_name': first_name,
                'last_name': last_name,
                'email': email,
                'phone_number': phone_number,
                'showtime_id': film_show_id,
                'confirmation_email': 'on' if confirmation_email else '',
                'paid': 'on' if paid else '',
                'confirmed': 'on' if confirmed else ''}

        self.session.post(APP_URL + r'/worker/podsumowanie/', data=data)

        return data

    def create_reservation(self, film_show_id: int, first_name: str, last_name: str,
                           email: str, phone_number: str, paid: bool, confirmed: bool, confirmation_email: bool,
                           ticket_type_id: str, seat_id_b_row: str = 7):
        """
        Creates reservation using requests

        :param film_show_id: film show id
        :param first_name: first name
        :param last_name: last name
        :param email: user email
        :param phone_number: phone number
        :param paid: is paid (has to be boolean)
        :param confirmed: is confirmed (has to be boolean)
        :param confirmation_email: send confirmation email (has to be boolean)
        :param seat_id_b_row: id of seat in b row (7 by default)
        :param ticket_type_id: id of ticket type
        :return:
        """

        self._login()

        self.__save_first_tab(film_show_id, first_name, last_name, email, phone_number, paid, confirmed,
                              confirmation_email, seat_id_b_row)
        self.__save_second_tab(film_show_id, first_name, last_name, email, phone_number, paid, confirmed,
                               confirmation_email, seat_id_b_row, ticket_type_id)
        self.__save_third_tab_send_reservation(film_show_id, first_name, last_name, email, phone_number, paid,
                                               confirmed, confirmation_email, seat_id_b_row, ticket_type_id)

        self._close_session()
