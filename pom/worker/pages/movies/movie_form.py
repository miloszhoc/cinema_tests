from pom.worker.pages.top_menu import TopMenuP
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
import pom.worker.pages.movies.movie_details as movie_details


class MovieAddFormP(TopMenuP):
    INPUT_TITLE_S = (By.NAME, 'title')
    INPUT_DIRECTOR_S = (By.NAME, 'director')
    INPUT_RELEASE_YEAR_S = (By.NAME, 'release_date')
    INPUT_DURATION_S = (By.NAME, 'duration')
    INPUT_DESCRIPTION_S = (By.NAME, 'description')
    INPUT_LINK_S = (By.NAME, 'link')
    UPLOAD_THUMBNAIL_S = (By.NAME, 'thumbnail')
    INPUT_YT_ID_S = (By.NAME, 'trailer_youtube_id')
    CHECKBOX_DELETED_S = (By.NAME, 'deleted')
    BUTTON_SAVE_S = (By.XPATH, '//button[@type="submit"]')

    OPTION_DURATION_D = (By.XPATH, '//a[contains(text(), "{}")]//parent::li[@class="ui-menu-item"]')

    def add_movie(self,
                  title: str,
                  director: str, release_year: str, description: str, link: str,
                  thumbnail_file_path: str, youtube_id: str, deleted: bool,
                  duration: str = '00:15:00') -> movie_details.MovieDetailsP:
        """
        Add movie and redirect to movie details.

        :return: movie details page.
        """
        self._type_movie_title(title)
        self._type_director(director)
        self._type_release_year(release_year)
        self._type_duration(duration)
        self._type_description(description)
        self._type_link(link)
        self._upload_thumbnail(thumbnail_file_path)
        self._type_yt_id(youtube_id)

        self._check_deleted_checkbox() if deleted else None

        return self._click_save_button()

    def _type_movie_title(self, title: str) -> str:
        self.wait_and_type(self.INPUT_TITLE_S, title)
        return title

    def _type_director(self, director: str) -> str:
        self.wait_and_type(self.INPUT_DIRECTOR_S, director)
        return director

    def _type_release_year(self, release_year: str) -> str:
        self.wait_and_type(self.INPUT_RELEASE_YEAR_S, release_year)
        return release_year

    def _type_duration(self, duration: str = '00:15:00') -> str:
        action = ActionChains(self.driver)
        action.click(self.driver.find_element(*self.INPUT_DURATION_S)).perform()
        action.click(self.driver.find_element(*self.dynamic_locator(self.OPTION_DURATION_D, duration))).perform()
        return duration

    def _type_description(self, description: str) -> str:
        self.wait_and_type(self.INPUT_DESCRIPTION_S, description)
        return description

    def _type_link(self, link: str) -> str:
        self.wait_and_type(self.INPUT_LINK_S, link)
        return link

    def _upload_thumbnail(self, file_path: str) -> str:
        self._wait_for_visibility(self.UPLOAD_THUMBNAIL_S)
        self.driver.find_element(*self.UPLOAD_THUMBNAIL_S).send_keys(file_path)
        return file_path

    def _type_yt_id(self, yt_id: str) -> str:
        self.wait_and_type(self.INPUT_YT_ID_S, yt_id)
        return yt_id

    def _check_deleted_checkbox(self) -> bool:
        self.wait_and_click(self.CHECKBOX_DELETED_S)
        return True

    def _click_save_button(self):
        self.wait_and_click(self.BUTTON_SAVE_S)
        return movie_details.MovieDetailsP(self.driver)
