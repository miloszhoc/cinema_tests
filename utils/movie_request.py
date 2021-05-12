import requests
from bs4 import BeautifulSoup

from env_data import APP_URL, STAFF_ADMIN_PASS, STAFF_ADMIN_LOG, IMG_FILE


class CreateMovie:

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

    def create_movie(self,
                     title: str,
                     director: str, release_year: str, description: str, link: str,
                     thumbnail_file_path: str, thumbnail_name: str, youtube_id: str, deleted: bool,
                     duration: str = '00:15:00') -> bool:
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
        :return: True or raises exception
        """

        self.__login()
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
        self.__close_session()
        if r.status_code == 200:
            return True
        else:
            raise AssertionError('Cann not create movie.')
