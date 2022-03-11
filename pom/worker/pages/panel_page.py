import allure
from selenium.webdriver.common.by import By

from pom.worker.pages.top_menu import TopMenuP
import pom.worker.pages.movies.list_page as movie_list
import pom.worker.pages.film_show.list_page as show_list
import pom.worker.pages.manage_users.list_page as users_list
import pom.worker.pages.ticket_types.list_page as ticket_list


class PanelP(TopMenuP):
    HREF_MODULE_D = (By.XPATH, '//a[contains(text(), "{}")]')

    @allure.step("Open module {1}")
    def open_module(self, module_name: str):
        """
        Open module

        :param module_name: name of the module (link's text)
        :return: chosen module
        """
        self.wait_and_click(self.dynamic_locator(self.HREF_MODULE_D, module_name))

        if module_name == 'Zarządzanie użytkownikami':
            return users_list.ManageUsersListP(self.driver)
        elif module_name == 'Seanse':
            return show_list.ActiveFilmShowListP(self.driver)
        elif module_name == 'Filmy':
            return movie_list.ActiveMoviesListP(self.driver)
        elif module_name == 'Typy biletów':
            return ticket_list.ActiveTicketTypesListP(self.driver)
