import allure

from pom.worker.pages.top_menu import TopMenuP
from selenium.webdriver.common.by import By


class MovieDeleteP(TopMenuP):
    TEXT_SECTION_HEADING_S = (By.TAG_NAME, 'h1')
    BUTTON_YES_S = (By.XPATH, '//button[@value="Yes"]')
    BUTTON_NO_S = (By.XPATH, '//a[contains(text(), "Nie")]')

    @allure.step("Open deleted movies list.")
    def check_movie_title(self, title: str) -> bool:
        """
        Check if movie title is in heading.

        :param title: movie title
        :return: True or false.
        """
        return title in self.get_text(self.TEXT_SECTION_HEADING_S)

    @allure.step("Confirm movie deletion")
    def delete_movie(self):
        """
        click "yes" button.

        :return: List page
        """
        import pom.worker.pages.movies.list_page as list_page
        self.wait_and_click(self.BUTTON_YES_S)
        return list_page.ActiveMoviesListP(self.driver)

    @allure.step("Abandon movie delete form")
    def exit_form_without_deletion(self):
        """
        click "no" button.

        :return: Movie details.
        """
        import pom.worker.pages.movies.movie_details as movie_details

        self.wait_and_click(self.BUTTON_NO_S)
        return movie_details.MovieDetailsP(self.driver)
