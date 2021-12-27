import selenium.common.exceptions as se
from selenium.webdriver import Chrome


class Assertions:

    @staticmethod
    def is_element_on_page(driver: Chrome, locator: tuple) -> bool:
        """
        Returns True if element is on page in other case returns False.

        :param driver: driver instance
        :param locator: locator to element
        :return: True or False
        """
        try:
            driver.find_element(*locator)
        except se.NoSuchElementException:
            return False
        else:
            return True

    @staticmethod
    def check_url(driver: Chrome, expected: str) -> bool:
        """
        Check if user is on expected page.

        :param driver: driver instance
        :param expected: expected part of url
        :return: True or False
        """
        return expected in driver.current_url
