from pom.base.checks import Assertions
from pom.base.manager import PageManager
from selenium.webdriver.common.by import By
from pom.worker.pages.film_show.reservations.reservation_form import ReservationAddForm1stTabP


class ReservationListP(PageManager):
    HREF_ADD_RESERVATION_S = (By.LINK_TEXT, 'Dodaj rezerwację')
    TEXT_TABLE_HEADER_D = (By.XPATH, '//th[contains(text(), "{}")]')
    HREF_RESERVATION_DETAILS_D = (By.XPATH,
                                  '//td[contains(text(), "{person_name}")]//..//following-sibling::tr[1]//sup')
    TEXT_RESERVATION_DETAILS_NAME_VALUE_D = (By.XPATH,
                                             '//td[contains(text(), "{person_name}")]//..//following-sibling::tr[1]//div[@class="name" and contains(text(), "{name}")]//following-sibling::div[contains(text(), "{value}")]')
    TEXT_RESERVATION_PAID_D = (By.XPATH,
                               '//td[contains(text(), "{person_name}")]//following-sibling::td[@class="is_paid"]')
    TEXT_RESERVATION_CONFIRMED_D = (By.XPATH,
                                    '//td[contains(text(), "{person_name}")]//following-sibling::td[@class="is_confirmed"]')
    HREF_PAY_CONFIRM_RESERVATION_FORM_D = (By.XPATH,
                                           '//td[contains(text(), "{person_name}")]//following-sibling::td[@class="pay_confirm"]/a')
    HREF_DELETE_RESERVATION_FORM_D = (By.XPATH,
                                      '//td[contains(text(), "{person_name}")]//following-sibling::td[@class="delete_res"]/a')
    HREF_UPDATE_RESERVATION_FORM_D = (By.XPATH,
                                      '//td[contains(text(), "{person_name}")]//following-sibling::td[@class="edit"]/a')

    def open_add_reservation_form(self) -> ReservationAddForm1stTabP:
        self.wait_and_click(self.HREF_ADD_RESERVATION_S)
        return ReservationAddForm1stTabP(self.driver)

    def open_reservation_details(self, person_name: str):
        """
        Opens reservation details for a particular client

        :param person_name: person's name (has to be unique in show details)
        :return: None
        """

        self.wait_and_click(self.dynamic_locator(self.HREF_RESERVATION_DETAILS_D, person_name=person_name))

    def check_reservation_details(self, person_name: str, field_name: str, field_value: str) -> bool:
        """
        Checks reservation details. (checks if element exists)

        :param person_name: person's name (has to be unique in show details)
        :param field_name: field name (e.g. Email)
        :param field_value: field value (e.g. test@example.com)
        :return: True or False
        """

        return Assertions.is_element_on_page(self.driver,
                                             self.dynamic_locator(self.TEXT_RESERVATION_DETAILS_NAME_VALUE_D,
                                                                  person_name=person_name,
                                                                  name=field_name,
                                                                  value=field_value))

    def open_pay_confirm_form(self, person_name: str):
        """
        Opens form used to mark reservation as confirmed or paid

        :param person_name: person's name (has to be unique in show details)
        :return: reservation pay confirm form page
        """
        from pom.worker.pages.film_show.reservations.reservation_pay_confirm_form import ReservationPayConfirmFormP

        self.wait_and_click(self.dynamic_locator(self.HREF_PAY_CONFIRM_RESERVATION_FORM_D, person_name=person_name))
        return ReservationPayConfirmFormP(self.driver)

    def open_delete_reservation_page(self, person_name: str):
        """
        Opens form used to delete reservation

        :param person_name: person's name (has to be unique in show details)
        :return: reservation delete page
        """
        from pom.worker.pages.film_show.reservations.reservation_delete import ReservationDeleteP

        self.wait_and_click(self.dynamic_locator(self.HREF_DELETE_RESERVATION_FORM_D, person_name=person_name))
        return ReservationDeleteP(self.driver)

    def open_update_reservation_page(self, person_name: str):
        """
        Opens form used to update reservation

        :param person_name: person's name (has to be unique in show details)
        :return: reservation update page
        """
        from pom.worker.pages.film_show.reservations.reservation_update_form import ReservationUpdateFormP

        self.wait_scroll_and_click(self.dynamic_locator(self.HREF_UPDATE_RESERVATION_FORM_D, person_name=person_name))
        return ReservationUpdateFormP(self.driver)
