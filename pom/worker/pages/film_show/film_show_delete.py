from pom.worker.pages.top_menu import TopMenuP
from selenium.webdriver.common.by import By


class FilmShowDeleteP(TopMenuP):
    TEXT_SECTION_HEADING_S = (By.TAG_NAME, 'h1')
    BUTTON_YES_S = (By.XPATH, '//button[@value="Yes"]')
    BUTTON_NO_S = (By.XPATH, '//a[contains(text(), "Nie")]')

    def check_film_show_title_date(self, title: str) -> bool:
        """
        Check if film show title is in heading.

        :param title: film show title
        :return: True or false.
        """
        return title in self.get_text(self.TEXT_SECTION_HEADING_S)

    def delete_film_show(self):
        """
        click "yes" button.

        :return: List page
        """
        import pom.worker.pages.film_show.list_page as list_page
        self.wait_and_click(self.BUTTON_YES_S)
        return list_page.ActiveFilmShowListP(self.driver)

    def exit_form_without_deletion(self):
        """
        click "no" button.

        :return: Film show details.
        """
        import pom.worker.pages.film_show.film_show_details as film_show_details

        self.wait_and_click(self.BUTTON_NO_S)
        return film_show_details.FilmShowDetailsP(self.driver)
