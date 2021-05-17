from bs4 import BeautifulSoup

from env_data import APP_URL
from utils.common_request import CommonRequest


class CreateTicketType(CommonRequest):

    def create_ticket_type(self, type_name: str, price: str, conditions: str, deleted: bool) -> bool:
        """
        Creates ticket type using requests.

        :param type_name: ticket type name
        :param price: price
        :param conditions: conditions
        :param deleted: is deleted
        :return: True or raises exception
        """
        self._login()
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
        self._close_session()
        if r.status_code == 200:
            return True
        else:
            raise AssertionError('Cann not create ticket type.')
