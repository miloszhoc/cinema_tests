from selenium.webdriver.common.by import By

from pom.base.manager import PageManager


class ManageUsersListP(PageManager):
    HREF_TOP_MENU_D = (By.XPATH, '//a[contains(text(), "{}")]')
    DIV_LAST_ACTIONS_S = (By.ID, 'recent-actions-module')
    HREF_MODEL_USERS_S = (By.LINK_TEXT, 'Użytkownicy')
