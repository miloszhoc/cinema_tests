import allure
from selenium.webdriver.common.by import By

from pom.client.pages.reservation.reservation_form_page import ReservationAddForm1stTabP
from pom.client.pages.top_menu import TopMenuP


class RepertoireP(TopMenuP):
    BUTTON_OPEN_RESERVATION_FORM_D = (By.XPATH, '//td[contains(text(), "{}")]/following-sibling::td/a')
    TEXT_START_TIME_D = (By.XPATH, '//tr/td[contains(text(), "{}")]/following-sibling::td[@class="start_time"]')
    TEXT_END_TIME_D = (By.XPATH, '//tr/td[contains(text(), "{}")]/following-sibling::td[@class="end_time"]')

    @allure.step("Open reservation form of {1} movie")
    def open_reservation_form(self, movie_title: str):
        """
        Opens reservation form for the film show

        :param movie_title: title of the movie
        :return: reservation form first tab page
        """
        self.wait_and_click(self.dynamic_locator(self.BUTTON_OPEN_RESERVATION_FORM_D, movie_title))
        return ReservationAddForm1stTabP(self.driver)

    @allure.step("Get start time of {1} movie")
    def get_start_time(self, movie_title: str):
        """
        Get start time (MM:HH) for the given film show

        :param movie_title: movie title
        :return: start time
        """
        return self.get_text(self.dynamic_locator(self.TEXT_START_TIME_D, movie_title))

    @allure.step("Get end time of {1} movie")
    def get_end_time(self, movie_title: str):
        """
        Get end time (MM:HH) for the given film show

        :param movie_title: movie title
        :return: end time
        """
        return self.get_text(self.dynamic_locator(self.TEXT_END_TIME_D, movie_title))
