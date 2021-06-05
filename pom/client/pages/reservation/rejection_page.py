from selenium.webdriver.common.by import By

from pom.base.manager import PageManager
from pom.client.pages.main_page import MainP


class RejectionP(PageManager):
    BUTTON_REJECT_S = (By.XPATH, '//button[@type="submit"]')

    def reject_reservation(self):
        self.wait_and_click(self.BUTTON_REJECT_S)
        return MainP(self.driver)
