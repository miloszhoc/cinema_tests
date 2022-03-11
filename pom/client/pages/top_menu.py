import allure
from selenium.webdriver.common.by import By
from pom.base.manager import PageManager


class TopMenuP(PageManager):
    HREF_MAIN_PAGE_S = (By.XPATH, '//li[@class="nav-item"]/a[contains(text(), "Strona główna")]')
    HREF_REPERTOIRE_PAGE_S = (By.XPATH, '//li[@class="nav-item"]/a[contains(text(), "Repertuar")]')
    HREF_PRICE_LIST_PAGE_S = (By.XPATH, '//li[@class="nav-item"]/a[contains(text(), "Cennik")]')
    HREF_ABOUT_PAGE_S = (By.XPATH, '//li[@class="nav-item"]/a[contains(text(), "O kinie")]')
    HREF_CONTACT_PAGE_S = (By.XPATH, '//li[@class="nav-item"]/a[contains(text(), "Kontakt")]')
    TEXT_TAB_NAME_S = (By.XPATH, '//h1[@class="logo-text"]')

    @allure.step("Open main page")
    def open_main_page(self):
        """
        Open main page.

        :return: main page
        """
        import pom.client.pages.main_page as main_page

        self.wait_and_click(self.HREF_MAIN_PAGE_S)
        return main_page.MainP(self.driver)

    @allure.step("Open repertoire page")
    def open_repertoire_page(self):
        """
        Open repertoire page.

        :return: repertoire page
        """
        import pom.client.pages.repertoire_page as repertoire_page

        self.wait_and_click(self.HREF_REPERTOIRE_PAGE_S)
        return repertoire_page.RepertoireP(self.driver)

    @allure.step("Open price list page.")
    def open_price_list_page(self):
        """
        Open price list page.

        :return: price list page
        """
        import pom.client.pages.price_list_page as price_list_page

        self.wait_and_click(self.HREF_PRICE_LIST_PAGE_S)
        return price_list_page.PriceListP(self.driver)

    @allure.step("Open about page.")
    def open_about_page(self):
        """
        Open about cinema page.

        :return: about page
        """
        import pom.client.pages.about_page as about_page

        self.wait_and_click(self.HREF_ABOUT_PAGE_S)
        return about_page.AboutP(self.driver)

    @allure.step("Open contact page.")
    def open_contact_page(self):
        """
        Open contact page.

        :return: contact page
        """
        import pom.client.pages.contact_page as contact_page

        self.wait_and_click(self.HREF_CONTACT_PAGE_S)
        return contact_page.ContactP(self.driver)

    @allure.step("Get page title")
    def get_page_title(self):
        """
        Get page title.

        :return: page title
        """
        return self.get_text(self.TEXT_TAB_NAME_S)
