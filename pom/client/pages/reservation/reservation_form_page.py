from selenium.webdriver.common.by import By
from selenium.webdriver.support.select import Select

from pom.client.pages.top_menu import TopMenuP


class ReservationAddForm1stTabP(TopMenuP):
    INPUT_NAME_S = (By.NAME, 'first_name')
    INPUT_LAST_NAME_S = (By.NAME, 'last_name')
    INPUT_EMAIL_S = (By.NAME, 'email')
    INPUT_PHONE_S = (By.NAME, 'phone_number')
    CHECKBOX_SEAT_D = (By.XPATH, '//label[contains(text(), "{}")]//input[@type="checkbox"]')
    BUTTON_NEXT_S = (By.XPATH, '//button[@type="submit"]')
    TEXT_MESSAGE_S = (By.CLASS_NAME, 'message')

    def get_message(self) -> str:
        """
        Get message which appears on screen

        :return: message content
        """
        return self.get_text(self.TEXT_MESSAGE_S)

    def fill_out_first_tab(self, name: str, last_name: str, email: str, number: str, seat: str):
        self._type_name(name)
        self._type_last_name(last_name)
        self._type_email(email)
        self._type_phone_number(number)
        self._choose_seat(seat)

        return self._click_next_button()

    def _type_name(self, name: str) -> str:
        self.wait_and_type(self.INPUT_NAME_S, name)
        return name

    def _type_last_name(self, last_name: str) -> str:
        self.wait_and_type(self.INPUT_LAST_NAME_S, last_name)
        return last_name

    def _type_email(self, email: str) -> str:
        self.wait_and_type(self.INPUT_EMAIL_S, email)
        return email

    def _type_phone_number(self, number: str) -> str:
        self.wait_and_type(self.INPUT_PHONE_S, number)
        return number

    def _choose_seat(self, seat: str) -> str:
        """
        Check seat.

        :param seat: seat code (e.g. A1)
        :return: seat code
        """
        self.wait_and_click(self.dynamic_locator(self.CHECKBOX_SEAT_D, seat))
        return seat

    def _click_next_button(self):
        self.wait_and_click(self.BUTTON_NEXT_S)
        return ReservationAddForm2ndTabP(self.driver)


class ReservationAddForm2ndTabP(TopMenuP):
    TEXT_SUMMARY_D = (By.XPATH, '//td[contains(text(), "{label}")]//following-sibling::td[contains(text(), "{value}")]')
    BUTTON_NEXT_S = (By.XPATH, '//button[@type="submit"]')
    SELECT_TICKET_TYPE_D = (By.XPATH,
                            '//option[contains(text(), "{}") and @selected]/../../../following-sibling::div[contains(@id, "tickettype_id")]//select')

    def fill_out_second_tab(self, seat_label: str, ticket_type_name: str):
        self._choose_ticket_type(seat_label, ticket_type_name)
        return self._click_next_button()

    def check_summary(self, label: str, value: str) -> bool:
        """
        Checks data from previous tab in summary table.

        :param label: field label
        :param value: field value
        :return: True or false
        """
        return self.is_element_on_page(self.dynamic_locator(self.TEXT_SUMMARY_D, label=label, value=value))

    def _choose_ticket_type(self, seat_label: str, ticket_type_name: str) -> dict:
        """

        Choose ticket type for a seat.

        :param seat_label: seat label (e.g. A1)
        :param ticket_type_name: ticket type name
        :return: dict (seat_label: ticket_type_name)
        """
        Select(self.driver.find_element(
            *self.dynamic_locator(self.SELECT_TICKET_TYPE_D, seat_label))).select_by_visible_text(ticket_type_name)
        return {seat_label: ticket_type_name}

    def _click_next_button(self):
        self.wait_and_click(self.BUTTON_NEXT_S)
        return ReservationAddForm3rdTabP(self.driver)


class ReservationAddForm3rdTabP(TopMenuP):
    TEXT_SUMMARY_D = (By.XPATH, '//td[contains(text(), "{label}")]//following-sibling::td[contains(text(), "{value}")]')
    BUTTON_SEND_RESERVATION_S = (By.XPATH, '//input[@value="Zarezerwuj"]')
    TEXT_TICKET_TYPE_D = (By.XPATH,
                          '//div[@class="seat_name" and contains(text(), "{seat}")]//following-sibling::div[@class="ticket_type" and contains(text(), "{ticket}")]')
    TEXT_TOTAL_PRICE_S = (By.ID, 'total_price')

    def check_summary(self, label: str, value: str) -> bool:
        """
        Checks data from previous tab in summary table.

        :param label: field label
        :param value: field value
        :return: True or false
        """
        return self.is_element_on_page(self.dynamic_locator(self.TEXT_SUMMARY_D, label=label, value=value))

    def check_ticket_type(self, seat_label: str, ticket_type_name: str):
        return self.is_element_on_page(
            self.dynamic_locator(self.TEXT_TICKET_TYPE_D, seat=seat_label, ticket=ticket_type_name))

    def check_total_price(self, total_price: str):
        return total_price.replace('.', ',') in self.get_text(self.TEXT_TOTAL_PRICE_S)

    def send_reservation(self):
        """
        Send reservation and redirect to film show details

        :return: film show details page.
        """
        from pom.client.pages.movie_details_page import MovieDetailsP

        self.wait_and_click(self.BUTTON_SEND_RESERVATION_S)
        return MovieDetailsP(self.driver)
