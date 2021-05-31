from selenium.webdriver.common.by import By

from pom.client.pages.movie_details_page import MovieDetailsP
from pom.client.pages.top_menu import TopMenuP


class MainP(TopMenuP):
    HREF_MOVIE_DETAILS_D = (By.XPATH, '//a/div[contains(text(), "{}")]')

    def open_movie_details(self, movie_title: str):
        """
        Open movie details

        :param movie_title: title of the movie
        :return: movie details page
        """
        self.wait_and_click(self.dynamic_locator(self.HREF_MOVIE_DETAILS_D, movie_title))
        return MovieDetailsP(self.driver)
