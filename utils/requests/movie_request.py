from bs4 import BeautifulSoup

from env_data import APP_URL
from utils.requests.common_request import CommonRequest


class CreateMovie(CommonRequest):

    def create_movie(self,
                     title: str,
                     director: str, release_year: str, description: str, link: str,
                     thumbnail_file_path: str, thumbnail_name: str, youtube_id: str, deleted: bool,
                     duration: str = '00:15:00') -> int:
        """
        Creates movie using requests.



        :param thumbnail_name: thumbnail file name
        :param title: movie title
        :param director: movie director
        :param release_year: release year
        :param description: movie description
        :param link: link website with ratings
        :param thumbnail_file_path: thumbnail file path
        :param youtube_id: youtube video id
        :param deleted: is deleted
        :param duration: movie duration
        :return: movie id or raises exception
        """

        self._login()
        self.session.get(APP_URL + r'/worker/filmy/')
        r = self.session.get(APP_URL + r'/worker/dodaj-film/')
        page_source_form_add_ticket = r.text
        csrf_form_add_ticket = BeautifulSoup(page_source_form_add_ticket,
                                             'html.parser').find('input', {'name': "csrfmiddlewaretoken"}).get('value')

        files = {"thumbnail": (thumbnail_name, open(thumbnail_file_path, "rb"), 'image/png')}

        r = self.session.post(APP_URL + r'/worker/dodaj-film/', data={'csrfmiddlewaretoken': csrf_form_add_ticket,
                                                                      'title': title,
                                                                      'director': director,
                                                                      'release_date': release_year,
                                                                      'duration': duration,
                                                                      'description': description,
                                                                      'link': link,
                                                                      'trailer_youtube_id': youtube_id,
                                                                      'deleted': 'on' if deleted else ''},
                              files=files)
        self._close_session()
        if r.status_code == 200:
            return r.url.split('/')[-1]
        else:
            raise AssertionError('Cann not create movie.')
