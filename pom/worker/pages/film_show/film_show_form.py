from selenium.webdriver import ActionChains

from pom.worker.pages.top_menu import TopMenuP
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
import pom.worker.pages.film_show.film_show_details as film_show_details
import pom.worker.pages.movies.movie_form as movie_form


class FilmShowAddFormP(TopMenuP):
    HREF_ADD_MOVIE_S = (By.LINK_TEXT, 'Dodaj seans')
    SELECT_MOVIE_S = (By.NAME, 'movie_id')
    INPUT_START_DATE_S = (By.NAME, 'start_date')
    DIV_DATETIME_PICKER_S = (By.XPATH, '//div[@class="xdsoft_datetimepicker xdsoft_noselect xdsoft_"]')
    INPUT_SHOW_BREAK_S = (By.NAME, 'show_break')
    BUTTON_SAVE_S = (By.XPATH, '//button[@type="submit"]')

    OPTION_BREAK_TIME_D = (By.XPATH, '//a[contains(text(), "{}")]//parent::li[@class="ui-menu-item"]')

    def add_film_show(self,
                      movie_title: str,
                      start_datetime: str,
                      break_time: str = '00:10:00') -> film_show_details.FilmShowDetailsP:
        """
        Add film show and redirect to film show details.

        :param movie_title: existing movie title
        :param start_datetime: start datetime (format: YYYY-MM-DD HH:MM e.g: 2021-05-14 00:18)
        :param break_time: show break time (e.g: 00:10:00)

        :return: Film show details page
        """
        self._select_movie_title(movie_title)
        self._type_show_break_time(break_time)
        self._type_start_datetime(start_datetime)
        return self._click_save_button()

    def open_add_movie_form(self) -> movie_form.MovieAddFormP:
        """
        Open add movie form

        :return: Movie add form page
        """
        self.wait_and_click(self.HREF_ADD_MOVIE_S)
        return movie_form.MovieAddFormP(self.driver)

    def _select_movie_title(self, movie_title: str) -> str:
        select = Select(self.driver.find_element(*self.SELECT_MOVIE_S))
        select.select_by_visible_text(movie_title)
        return movie_title

    def _type_start_datetime(self, start_datetime: str) -> str:
        action = ActionChains(self.driver)
        action.move_to_element(self.driver.find_element(*self.INPUT_START_DATE_S)).click().perform()
        assert 'display: block;' in self.get_element_attr(self.DIV_DATETIME_PICKER_S, 'style')
        self.wait_and_type(self.INPUT_START_DATE_S, start_datetime)
        action2 = ActionChains(self.driver)
        action2.click(self.driver.find_element(*self.INPUT_START_DATE_S)).perform()
        return start_datetime

    def _type_show_break_time(self, break_time: str = '00:10:00') -> str:
        action = ActionChains(self.driver)
        action.click(self.driver.find_element(*self.INPUT_SHOW_BREAK_S)).perform()
        action.click(self.driver.find_element(*self.dynamic_locator(self.OPTION_BREAK_TIME_D, break_time))).perform()
        return break_time

    def _click_save_button(self):
        self.wait_and_click(self.BUTTON_SAVE_S)
        return film_show_details.FilmShowDetailsP(self.driver)
