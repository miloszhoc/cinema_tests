import allure
from selenium.webdriver.common.by import By

from pom.client.pages.movie_details_page import MovieDetailsP
from pom.client.pages.top_menu import TopMenuP


class MainP(TopMenuP):
    TEXT_MESSAGE_S = (By.CLASS_NAME, 'message')
    HREF_MOVIE_DETAILS_D = (By.XPATH, '//a/div[contains(text(), "{}")]')

    @allure.step("Get message which appears on screen")
    def get_message(self) -> str:
        """
        Get message which appears on screen

        :return: message content
        """
        return self.get_text(self.TEXT_MESSAGE_S)

    @allure.step("Open {1} movie details")
    def open_movie_details(self, movie_title: str):
        """
        Open movie details

        :param movie_title: title of the movie
        :return: movie details page
        """
        self.wait_and_click(self.dynamic_locator(self.HREF_MOVIE_DETAILS_D, movie_title))
        return MovieDetailsP(self.driver)
