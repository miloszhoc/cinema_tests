from pom.base.manager import PageManager
from selenium.webdriver.common.by import By
import pom.worker.pages.panel_page as panel_page


class PreLoginP(PageManager):
    HREF_LOGIN_L = (By.LINK_TEXT, 'Zaloguj')

    def enter_login_page(self):
        self.wait_and_click(self.HREF_LOGIN_L)
        return LoginP(self.driver)


class LoginP(PageManager):
    INPUT_LOGIN_L = (By.NAME, 'username')
    INPUT_PASSWD_L = (By.NAME, 'password')
    BUTTON_LOGIN_L = (By.XPATH, '//button[@type="submit"]')

    def login(self, login: str, passwd: str):
        self.wait_and_type(self.INPUT_LOGIN_L, login)
        self.wait_and_type(self.INPUT_PASSWD_L, passwd)
        self.wait_and_click(self.BUTTON_LOGIN_L)
        return panel_page.PanelP(self.driver)
