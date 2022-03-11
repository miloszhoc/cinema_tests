import allure

from pom.base.manager import PageManager
import pom.worker.pages.login_page as login_page
from selenium.webdriver.common.by import By
import pom.worker.pages.panel_page as panel_page


class TopMenuP(PageManager):
    TEXT_USERNAME_S = (By.XPATH, '//a[contains(text(), "Zalogowano jako")]')
    HREF_LOGOUT_S = (By.LINK_TEXT, 'Wyloguj')
    HREF_MAIN_PAGE_S = (By.XPATH, '//a[contains(text(), "Strona główna")]')

    @allure.step("Logout")
    def logout(self):
        self.wait_and_click(self.HREF_LOGOUT_S)
        return login_page.PreLoginP(self.driver)

    @allure.step("Open panel page")
    def open_panel_page(self):
        self.wait_and_click(self.HREF_MAIN_PAGE_S)
        return panel_page.PanelP(self.driver)
