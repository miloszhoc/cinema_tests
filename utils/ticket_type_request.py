import requests
from bs4 import BeautifulSoup

from env_data import APP_URL, STAFF_ADMIN_PASS, STAFF_ADMIN_LOG


class CreateTicketType:

    def __init__(self) -> None:
        super().__init__()
        self.session = requests.Session()

    def __update_cookie_header(self) -> None:
        self.session.headers['Vary'] = 'Cookie'
        self.session.headers['Cookie'] = 'csrftoken=' + self.session.cookies.get(
            'csrftoken') + ';' + 'sessionid=' + self.session.cookies.get('sessionid')

    def __login(self) -> None:
        page_source = self.session.get(APP_URL + '/worker/login/').text
        csrf = BeautifulSoup(page_source, 'html.parser').find('input', {'name': "csrfmiddlewaretoken"}).get('value')
        self.session.headers['Cookie'] = 'csrftoken=' + self.session.cookies.get('csrftoken')
        self.session.post(APP_URL + '/worker/login/', data={'username': STAFF_ADMIN_LOG,
                                                            'password': STAFF_ADMIN_PASS,
                                                            'csrfmiddlewaretoken': csrf})
        self.__update_cookie_header()

    def __close_session(self):
        self.session.close()

    def create_ticket_type(self, type_name: str, price: str, conditions: str, deleted: bool) -> bool:
        """
        Creates ticket type using requests.

        :param type_name: ticket type name
        :param price: price
        :param conditions: conditions
        :param deleted: is deleted
        :return: True or raises exception
        """
        self.__login()
        self.session.get(APP_URL + r'/worker/typy-biletow/')
        r = self.session.get(APP_URL + r'/worker/dodaj-typ/')
        page_source_form_add_ticket = r.text
        csrf_form_add_ticket = BeautifulSoup(page_source_form_add_ticket,
                                             'html.parser').find('input', {'name': "csrfmiddlewaretoken"}).get('value')
        r = self.session.post(APP_URL + r'/worker/dodaj-typ/', data={'csrfmiddlewaretoken': csrf_form_add_ticket,
                                                                     'type': type_name,
                                                                     'price': price,
                                                                     'conditions': conditions,
                                                                     'deleted': 'on' if deleted else ''})
        self.__close_session()
        if r.status_code == 200:
            return True
        else:
            raise AssertionError('Cann not create ticket type.')
