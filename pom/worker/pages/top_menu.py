from pom.base.manager import PageManager
import pom.worker.pages.login_page as login_page
from selenium.webdriver.common.by import By


class TopMenuP(PageManager):
    TEXT_USERNAME_L = (By.XPATH, '//a[contains(text(), "Zalogowano jako")]')
    HREF_LOGOUT_L = (By.LINK_TEXT, 'Wyloguj')
    HREF_MAIN_PAGE_L = (By.XPATH, '//a[contains(text(), "Strona główna")]')

    def logout(self):
        self.wait_and_click(self.HREF_LOGOUT_L)
        return login_page.PreLoginP(self.driver)
