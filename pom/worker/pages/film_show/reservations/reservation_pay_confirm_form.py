import allure
from selenium.webdriver.common.by import By

from pom.worker.pages.film_show.film_show_details import FilmShowDetailsP
from pom.worker.pages.top_menu import TopMenuP


class ReservationPayConfirmFormP(TopMenuP):
    INPUT_PAID_S = (By.NAME, 'paid')
    INPUT_CONFIRMED_S = (By.NAME, 'confirmed')
    BUTTON_SEND_S = (By.XPATH, '//input[@value="Zatwierdź"]')

    @allure.step("Check 'paid' checkbox")
    def _check_paid_checkbox(self):
        self.wait_and_click(self.INPUT_PAID_S)
        return True

    @allure.step("Check 'confirmed' checkbox")
    def _check_confirmed_checkbox(self):
        self.wait_and_click(self.INPUT_CONFIRMED_S)
        return True

    @allure.step("Send form")
    def send_form(self):
        self.wait_and_click(self.BUTTON_SEND_S)
        return FilmShowDetailsP(self.driver)

    @allure.step("mark reservation as paid or confirmed")
    def mark_reservation(self, paid: bool, confirmed: bool):
        """
        Mark reservation as paid or confirmed.

        :param paid: is reservation paid
        :param confirmed: is reservation confirmed
        :return: Show details page
        """
        if paid:
            self._check_paid_checkbox()
        if confirmed:
            self._check_confirmed_checkbox()
        return self.send_form()
