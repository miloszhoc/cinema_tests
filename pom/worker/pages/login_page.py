import allure

from pom.base.manager import PageManager
from selenium.webdriver.common.by import By
import pom.worker.pages.panel_page as panel_page


class PreLoginP(PageManager):
    HREF_LOGIN_S = (By.LINK_TEXT, 'Zaloguj')

    @allure.step("Open login page")
    def enter_login_page(self):
        self.wait_and_click(self.HREF_LOGIN_S)
        return LoginP(self.driver)


class LoginP(PageManager):
    INPUT_LOGIN_S = (By.NAME, 'username')
    INPUT_PASSWD_S = (By.NAME, 'password')
    BUTTON_LOGIN_S = (By.XPATH, '//button[@type="submit"]')

    @allure.step("Login using username: {1}, and password: {2}")
    def login(self, login: str, passwd: str):
        self.wait_and_type(self.INPUT_LOGIN_S, login)
        self.wait_and_type(self.INPUT_PASSWD_S, passwd)
        self.wait_and_click(self.BUTTON_LOGIN_S)
        return panel_page.PanelP(self.driver)
