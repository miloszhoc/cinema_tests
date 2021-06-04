from selenium.webdriver.common.by import By

from pom.client.pages.reservation_form_page import ReservationAddForm1stTabP
from pom.client.pages.top_menu import TopMenuP


class RepertoireP(TopMenuP):
    BUTTON_OPEN_RESERVATION_FORM_D = (By.XPATH, '//td[contains(text(), "{}")]/following-sibling::td/a')

    def open_reservation_form(self, movie_title: str):
        """
        Opens reservation form for the film show

        :param movie_title: title of the movie
        :return: reservation form first tab page
        """
        self.wait_and_click(self.dynamic_locator(self.BUTTON_OPEN_RESERVATION_FORM_D, movie_title))
        return ReservationAddForm1stTabP(self.driver)
