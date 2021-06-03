from selenium.webdriver.common.by import By

from pom.client.pages.reservation_form_page import ReservationAddForm1stTabP
from pom.client.pages.top_menu import TopMenuP


class MovieDetailsP(TopMenuP):
    TEXT_FIELD_VALUE_D = (By.XPATH,
                          '//div[@class="section"]//b[contains(text(), "{name}")]/../following-sibling::div[@class="value"]')
    FRAME_YT_S = (By.XPATH, '//iframe')
    IMG_THUMBNAIL_S = (By.XPATH, '//div[@class="container-bg"]//img')
    TEXT_LINK_REVIEW_S = (By.XPATH, '//div[@class="section"]//div[@class="card-text"]//a')
    BUTTON_RESERVATION_D = (By.XPATH,
                            '//td[contains(text(), "{datetime}")]/..//a[contains(text(), "Zarezerwuj miejsce")]')
    TEXT_MESSAGE_S = (By.CLASS_NAME, 'message')

    def get_field_value(self, field_name: str) -> str:
        """
        Get field value based on field name

        :param field_name: field name (e.g. Tytuł)
        :return: field value
        """
        return self.get_text(self.dynamic_locator(self.TEXT_FIELD_VALUE_D, name=field_name))

    def open_reservation_form(self, datetime: str):
        """
        Opens reservation form for a showtime

        :param datetime: datetime in DD-MM-YYYY HH:MM format
        :return: reservation form first tab page
        """
        self.wait_and_click(self.dynamic_locator(self.BUTTON_RESERVATION_D, datetime=datetime))
        return ReservationAddForm1stTabP(self.driver)

    def check_message(self, message: str) -> bool:
        """
        Checks message which appears on screen

        :param message: message content
        :return: True or false
        """
        return message in self.get_text(self.TEXT_MESSAGE_S)
