from webbrowser import Chrome

import allure

from pom.worker.pages.film_show.reservations.reservation_list import ReservationListP
from pom.worker.pages.top_menu import TopMenuP
from selenium.webdriver.common.by import By
import pom.worker.pages.film_show.film_show_delete as film_show_delete


class FilmShowDetailsP(TopMenuP):
    TEXT_MESSAGE_S = (By.CLASS_NAME, 'message')
    HREF_UPDATE_FILM_SHOW_S = (By.LINK_TEXT, 'Aktualizuj informacje o seansie')
    HREF_DELETE_FILM_SHOW_S = (By.LINK_TEXT, 'Usuń seans')
    HREF_MOVIE_DETAILS_S = (By.LINK_TEXT, 'Przejdź do szczegółów filmu')
    TEXT_FIELD_NAME_VALUE_D = (By.XPATH,
                               '//div[@class="name"]/b[contains(text(), "{name}")]//..//../div[contains(text(), "{value}")]')

    def __init__(self, driver: Chrome) -> None:
        super().__init__(driver)
        self.reservation_list = ReservationListP(self.driver)

    @allure.step("Open update film show form")
    def open_update_film_show_form(self):
        import pom.worker.pages.film_show.film_show_form as film_show_form

        self.wait_and_click(self.HREF_UPDATE_FILM_SHOW_S)
        return film_show_form.FilmShowAddFormP(self.driver)

    @allure.step("Open delete film show form")
    def open_delete_film_show_page(self) -> film_show_delete.FilmShowDeleteP:
        self.wait_and_click(self.HREF_DELETE_FILM_SHOW_S)
        return film_show_delete.FilmShowDeleteP(self.driver)

    @allure.step("Get message which appears on screen")
    def get_message(self) -> str:
        """
        Get message which appears on screen

        :return: message content
        """
        return self.get_text(self.TEXT_MESSAGE_S)
