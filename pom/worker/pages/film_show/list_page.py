import allure

from pom.worker.pages.top_menu import TopMenuP
from selenium.webdriver.common.by import By
import pom.worker.pages.film_show.film_show_form as film_show_form
import pom.worker.pages.film_show.film_show_details as film_show_details


class FilmShowListP(TopMenuP):
    TEXT_LIST_TITLE_D = (By.XPATH, '//h3[contains(text(), "{}")]')
    HREF_SHOW_DETAILS_D = (
        By.XPATH, '//td[contains(text(), "{}")]//following-sibling::td//a[contains(text(), "Przejdź do szczegółów")]')
    TEXT_TABLE_HEADER_D = (By.XPATH, '//th[contains(text(), "{}")]')

    @allure.step("Open film show details.")
    def open_film_show_details(self, film_show_title: str) -> film_show_details.FilmShowDetailsP:
        """
        Open film show details.

        :return: Film show details page.
        """
        self.wait_and_click(self.dynamic_locator(self.HREF_SHOW_DETAILS_D, film_show_title))
        return film_show_details.FilmShowDetailsP(self.driver)


class ArchiveFilmShowListP(FilmShowListP):
    pass


class ActiveFilmShowListP(FilmShowListP):
    HREF_ADD_SHOW_S = (By.LINK_TEXT, 'Dodaj seans')
    HREF_ARCHIVE_SHOW_S = (By.LINK_TEXT, 'Archiwalne Seanse')

    @allure.step("Open new film show form.")
    def open_add_film_show_form(self) -> film_show_form.FilmShowAddFormP:
        """
        Open new film show form.

        :return: Film show form.
        """
        self.wait_and_click(self.HREF_ADD_SHOW_S)
        return film_show_form.FilmShowAddFormP(self.driver)

    @allure.step("Open archive film show list")
    def open_archive_film_show_list(self) -> ArchiveFilmShowListP:
        """
        Open archive film show list.

        :return: Archive film show list.
        """
        self.wait_and_click(self.HREF_ARCHIVE_SHOW_S)
        return ArchiveFilmShowListP(self.driver)
