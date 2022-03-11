import allure
from selenium.webdriver.common.by import By

from pom.client.pages.top_menu import TopMenuP


class AboutP(TopMenuP):
    DIV_CARD_S = (By.XPATH, '//div[@class="card"]')

    @allure.step("Get number of elements with class=card")
    def get_number_of_cards(self):
        """
        Get number of elements with class=card


        :return: number of cards
        """
        return len(self.driver.find_elements(*self.DIV_CARD_S))
