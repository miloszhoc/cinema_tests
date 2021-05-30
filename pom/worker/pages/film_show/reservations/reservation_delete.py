from selenium.webdriver.common.by import By

from pom.worker.pages.top_menu import TopMenuP


class ReservationDeleteP(TopMenuP):
    BUTTON_DELETE_S = (By.XPATH, '//button[@value="Usuń"]')

    def delete_reservation(self):
        """
        Deletes reservation and redirects to film show page

        :return: film show details page
        """

        from pom.worker.pages.film_show.film_show_details import FilmShowDetailsP

        self.wait_and_click(self.BUTTON_DELETE_S)
        return FilmShowDetailsP(self.driver)

