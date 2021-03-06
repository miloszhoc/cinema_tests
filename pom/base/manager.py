from selenium.webdriver import Chrome
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
import selenium.webdriver.support.expected_conditions as ec


class PageManager(object):
    TEXT_ELEMENT_D = (By.XPATH, '//*[contains(text(), "{}")]')

    def __init__(self, driver: Chrome) -> None:
        """
        Base class which holds common methods for all pages.

        :param driver: webdriver instance
        """
        self.driver = driver

    def _wait_to_be_clickable(self, locator: tuple, timeout: int = 20) -> None:
        """
        Waits for element to be clickable.

        :param locator: locator to element.
        :param timeout: timeout.
        :return: None
        """

        WebDriverWait(self.driver, timeout).until(ec.element_to_be_clickable(locator))

    def _wait_for_visibility(self, locator: tuple, timeout: int = 20) -> None:
        """
        Waits for visibility of element.

        :param locator: locator to element.
        :param timeout: timeout.
        :return: None
        """

        WebDriverWait(self.driver, timeout).until(ec.visibility_of_element_located(locator))

    def wait_and_click(self, locator: tuple, timeout: int = 20) -> None:
        """
        Waits for element to be clickable and then click on it

        :param locator: locator to element.
        :param timeout: timeout.
        :return: None
        """
        self._wait_to_be_clickable(locator, timeout)
        element = self.driver.find_element(*locator)
        element.click()

    def wait_scroll_and_click(self, locator: tuple, timeout: int = 20) -> None:
        """
        Waits for element to be clickable, then scroll and click on it

        :param locator: locator to element.
        :param timeout: timeout.
        :return: None
        """
        self.driver.find_element(*locator).location_once_scrolled_into_view
        self._wait_to_be_clickable(locator, timeout)
        element = self.driver.find_element(*locator)
        element.click()

    def wait_and_type(self, locator: tuple, text: str, timeout: int = 20) -> str:
        """
        Waits for element to be visible and type text.

        :param locator: locator to element.
        :param text: text to type into field.
        :param timeout: timeout.
        :return: typed text
        """
        self._wait_for_visibility(locator, timeout)
        element = self.driver.find_element(*locator)
        element.clear()
        element.send_keys(text)
        return text

    def dynamic_locator(self, locator: tuple, *args, **kwargs) -> tuple:
        """
        Handles dynamic locator

        :param locator: element locator.
        :param args:
        :param kwargs:
        :return: new locator.
        """
        return (locator[0], locator[1].format(*args, **kwargs))

    def get_text(self, locator: tuple) -> str:
        """
        Get element's text.

        :param locator: locator to element.
        :return: Element's text.
        """
        return self.driver.find_element(*locator).text.strip()

    def get_element_attr(self, element_locator: tuple, attr_name: str):
        """
        Get element's attribute value.

        :param element_locator: locator to element
        :param attr_name: attribute name
        :return: attribute value
        """
        self._wait_for_visibility(element_locator)
        return self.driver.find_element(*element_locator).get_attribute(attr_name)
