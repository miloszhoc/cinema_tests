import allure

from pom.worker.pages.top_menu import TopMenuP
from selenium.webdriver.common.by import By
import pom.worker.pages.movies.movie_delete as movie_delete


class MovieDetailsP(TopMenuP):
    HREF_UPDATE_MOVIE_S = (By.LINK_TEXT, 'Aktualizuj informacje o filmie')
    HREF_DELETE_MOVIE_S = (By.LINK_TEXT, 'Usuń film')
    TEXT_FIELD_NAME_VALUE_D = (By.XPATH,
                               '//div[@class="name"]/b[contains(text(), "{name}")]//..//../div[contains(text(), "{value}")]')
    FRAME_YT_S = (By.XPATH, '//iframe')
    IMG_THUMBNAIL_S = (By.XPATH, '//div[@class="container"]//img')

    @allure.step("Update movie form")
    def open_update_movie_form(self):
        import pom.worker.pages.movies.movie_form as movie_form

        self.wait_and_click(self.HREF_UPDATE_MOVIE_S)
        return movie_form.MovieAddFormP(self.driver)

    @allure.step("Open delete movie page")
    def open_delete_movie_page(self) -> movie_delete.MovieDeleteP:
        self.wait_and_click(self.HREF_DELETE_MOVIE_S)
        return movie_delete.MovieDeleteP(self.driver)
