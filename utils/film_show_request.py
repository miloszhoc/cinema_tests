from bs4 import BeautifulSoup

from env_data import APP_URL
from utils.common_request import CommonRequest


class CreateFilmShow(CommonRequest):
    def create_film_show(self, movie_id: int, start_datetime: str, initial_start_datetime: str,
                         show_break: str) -> bool:
        """
        Creates film show using requests.

        :param movie_id: movie id
        :param start_datetime: film screening start date (in format: 2021-05-18 22:37)
        :param initial_start_datetime: current datetime (in format: 2021-05-18 22:37:04)
        :param show_break: show break (in format: 00:15:00)
        :return: film show id or raises exception
        """

        self._login()
        self.session.get(APP_URL + r'/worker/seanse/')
        r = self.session.get(APP_URL + r'/worker/dodaj-seans/')
        page_source_form_add_ticket = r.text
        csrf_form_add_film_show = BeautifulSoup(page_source_form_add_ticket,
                                                'html.parser').find('input', {'name': "csrfmiddlewaretoken"}).get(
            'value')
        r = self.session.post(APP_URL + r'/worker/dodaj-seans/', data={'csrfmiddlewaretoken': csrf_form_add_film_show,
                                                                       'movie_id': movie_id,
                                                                       'start_date': start_datetime,
                                                                       'initial-start_date': initial_start_datetime,
                                                                       'show_break': show_break})
        self._close_session()
        if r.status_code == 200:
            return r.url.split('/')[-1]
        else:
            raise AssertionError('Can not create film show.')
