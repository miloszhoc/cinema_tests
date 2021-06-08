from selenium.webdriver.common.by import By

from pom.base.manager import PageManager
from pom.client.pages.main_page import MainP


class ConfirmationP(PageManager):
    BUTTON_CONFIRM_S = (By.XPATH, '//input[@value="Potwierdź"]')

    def confirm_reservation(self):
        self.wait_and_click(self.BUTTON_CONFIRM_S)
        return MainP(self.driver)
