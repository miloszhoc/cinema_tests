from selenium.webdriver.common.by import By

from pom.client.pages.movie_details_page import MovieDetailsP
from pom.client.pages.top_menu import TopMenuP


class MainP(TopMenuP):
    TEXT_MESSAGE_S = (By.CLASS_NAME, 'message')
    HREF_MOVIE_DETAILS_D = (By.XPATH, '//a/div[contains(text(), "{}")]')

    def check_message(self, message: str) -> bool:
        """
        Checks message which appears on screen

        :param message: message content
        :return: True or false
        """
        return message in self.get_text(self.TEXT_MESSAGE_S)

    def open_movie_details(self, movie_title: str):
        """
        Open movie details

        :param movie_title: title of the movie
        :return: movie details page
        """
        self.wait_and_click(self.dynamic_locator(self.HREF_MOVIE_DETAILS_D, movie_title))
        return MovieDetailsP(self.driver)
