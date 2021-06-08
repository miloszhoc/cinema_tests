from selenium.webdriver.common.by import By

from pom.client.pages.top_menu import TopMenuP


class ContactP(TopMenuP):
    DIV_CARD_S = (By.XPATH, '//div[@class="card"]')
