from pom.worker.pages.film_show.reservations.reservation_form import ReservationAddForm1stTabP
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
    HREF_ADD_RESERVATION_S = (By.LINK_TEXT, 'Dodaj rezerwację')

    # reservation list
    TEXT_TABLE_HEADER_D = (By.XPATH, '//th[contains(text(), "{}")]')

    def open_update_film_show_form(self):
        import pom.worker.pages.film_show.film_show_form as film_show_form

        self.wait_and_click(self.HREF_UPDATE_FILM_SHOW_S)
        return film_show_form.FilmShowAddFormP(self.driver)

    def open_delete_film_show_page(self) -> film_show_delete.FilmShowDeleteP:
        self.wait_and_click(self.HREF_DELETE_FILM_SHOW_S)
        return film_show_delete.FilmShowDeleteP(self.driver)

    def open_add_reservation_form(self) -> ReservationAddForm1stTabP:
        self.wait_and_click(self.HREF_ADD_RESERVATION_S)
        return ReservationAddForm1stTabP(self.driver)

    def check_message(self, message: str) -> bool:
        """
        Checks message which appears on screen

        :param message: message content
        :return: True or false
        """
        return message in self.get_text(self.TEXT_MESSAGE_S)
