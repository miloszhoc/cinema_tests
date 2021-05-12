import requests
from bs4 import BeautifulSoup

from env_data import APP_URL, STAFF_ADMIN_PASS, STAFF_ADMIN_LOG


class CommonRequest():

    def __init__(self) -> None:
        """
        Common methods for creating data with requests.

        """
        super().__init__()
        self.session = requests.Session()

    def __update_cookie_header(self) -> None:
        self.session.headers['Vary'] = 'Cookie'
        self.session.headers['Cookie'] = 'csrftoken=' + self.session.cookies.get(
            'csrftoken') + ';' + 'sessionid=' + self.session.cookies.get('sessionid')

    def _login(self) -> None:
        """
        Login as user with maximum privileges.

        :return: None
        """
        page_source = self.session.get(APP_URL + '/worker/login/').text
        csrf = BeautifulSoup(page_source, 'html.parser').find('input', {'name': "csrfmiddlewaretoken"}).get('value')
        self.session.headers['Cookie'] = 'csrftoken=' + self.session.cookies.get('csrftoken')
        self.session.post(APP_URL + '/worker/login/', data={'username': STAFF_ADMIN_LOG,
                                                            'password': STAFF_ADMIN_PASS,
                                                            'csrfmiddlewaretoken': csrf})
        self.__update_cookie_header()

    def _close_session(self):
        self.session.close()
