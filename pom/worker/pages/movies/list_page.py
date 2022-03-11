import allure
from selenium.webdriver.common.by import By
import pom.worker.pages.movies.movie_form as movie_form

from pom.worker.pages.top_menu import TopMenuP
import pom.worker.pages.movies.movie_details as movie_details


class MovieListP(TopMenuP):
    TEXT_TABLE_HEADER_D = (By.XPATH, '//th[contains(text(), "{}")]')
    TEXT_LIST_TITLE_D = (By.XPATH, '//h3[contains(text(), "{}")]')
    HREF_MOVIE_DETAILS_D = (By.XPATH,
                            '//td[contains(text(), "{}")]//following-sibling::td//a[contains(text(), "Przejdź do szczegółów")]')
    TEXT_DELETED_COLUMN_VALUE_D = (By.XPATH,
                                   '//td[contains(text(), "{title}")]//following-sibling::td[contains(text(), "{deleted}")]')

    @allure.step("Open movie details.")
    def open_movie_details(self, movie_title: str) -> movie_details.MovieDetailsP:
        """
        Open movie details.

        :param movie_title: movie title
        :return: Movie details page
        """
        self.wait_and_click(self.dynamic_locator(self.HREF_MOVIE_DETAILS_D, movie_title))
        return movie_details.MovieDetailsP(self.driver)


class DeletedMovieListP(MovieListP):
    pass


class ActiveMoviesListP(MovieListP):
    HREF_ADD_MOVIE_S = (By.LINK_TEXT, 'Dodaj film')
    HREF_DELETED_MOVIES_S = (By.LINK_TEXT, 'Usunięte filmy')

    @allure.step("Open new movie form.")
    def open_add_movie_form(self) -> movie_form.MovieAddFormP:
        """
        Open new movie form.

        :return: Movie form.
        """
        self.wait_and_click(self.HREF_ADD_MOVIE_S)
        return movie_form.MovieAddFormP(self.driver)

    @allure.step("Open deleted movies list.")
    def open_deleted_movies_list(self) -> DeletedMovieListP:
        """
        Open deleted movies list.

        :return: Deleted movies list.
        """
        self.wait_and_click(self.HREF_DELETED_MOVIES_S)
        return DeletedMovieListP(self.driver)
