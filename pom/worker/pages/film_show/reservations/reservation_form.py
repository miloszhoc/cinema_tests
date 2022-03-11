import allure
from selenium.webdriver.common.by import By
from selenium.webdriver.support.select import Select

from pom.worker.pages.top_menu import TopMenuP


class ReservationAddForm1stTabP(TopMenuP):
    INPUT_NAME_S = (By.NAME, 'first_name')
    INPUT_LAST_NAME_S = (By.NAME, 'last_name')
    INPUT_EMAIL_S = (By.NAME, 'email')
    INPUT_PHONE_S = (By.NAME, 'phone_number')
    CHECKBOX_SEAT_D = (By.XPATH, '//label[contains(text(), "{}")]//input[@type="checkbox"]')
    BUTTON_NEXT_S = (By.XPATH, '//button[@value="Dalej"]')

    def fill_out_first_tab(self, name: str, last_name: str, email: str, number: str, seat: str):
        self._type_name(name)
        self._type_last_name(last_name)
        self._type_email(email)
        self._type_phone_number(number)
        self._choose_seat(seat)

        return self._click_next_button()

    @allure.step("Type name {1}")
    def _type_name(self, name: str) -> str:
        self.wait_and_type(self.INPUT_NAME_S, name)
        return name

    @allure.step("Type last name {1}")
    def _type_last_name(self, last_name: str) -> str:
        self.wait_and_type(self.INPUT_LAST_NAME_S, last_name)
        return last_name

    @allure.step("Type email {1}")
    def _type_email(self, email: str) -> str:
        self.wait_and_type(self.INPUT_EMAIL_S, email)
        return email

    @allure.step("Type phone number {1}")
    def _type_phone_number(self, number: str) -> str:
        self.wait_and_type(self.INPUT_PHONE_S, number)
        return number

    @allure.step("Choose {1} seat")
    def _choose_seat(self, seat: str) -> str:
        """
        Check seat.

        :param seat: seat code (e.g. A1)
        :return: seat code
        """
        self.wait_and_click(self.dynamic_locator(self.CHECKBOX_SEAT_D, seat))
        return seat

    @allure.step("Open second form tab")
    def _click_next_button(self):
        self.wait_and_click(self.BUTTON_NEXT_S)
        return ReservationAddForm2ndTabP(self.driver)


class ReservationAddForm2ndTabP(TopMenuP):
    TEXT_SUMMARY_D = (By.XPATH, '//td[contains(text(), "{label}")]//following-sibling::td[contains(text(), "{value}")]')
    BUTTON_NEXT_S = (By.XPATH, '//button[@value="Dalej"]')
    SELECT_TICKET_TYPE_D = (By.XPATH,
                            '//option[contains(text(), "{}") and @selected]/../../../following-sibling::div[contains(@id, "tickettype_id")]//select')

    def fill_out_second_tab(self, seat_label: str, ticket_type_name: str):
        self._choose_ticket_type(seat_label, ticket_type_name)
        return self._click_next_button()

    @allure.step("Check summary")
    def check_summary(self, label: str, value: str) -> bool:
        """
        Checks data from previous tab in summary table.

        :param label: field label
        :param value: field value
        :return: True or false
        """
        return self.is_element_on_page(self.dynamic_locator(self.TEXT_SUMMARY_D, label=label, value=value))

    @allure.step("Choose ticket type for a seat")
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

    @allure.step("Open third form tab")
    def _click_next_button(self):
        self.wait_and_click(self.BUTTON_NEXT_S)
        return ReservationAddForm3rdTabP(self.driver)


class ReservationAddForm3rdTabP(TopMenuP):
    TEXT_SUMMARY_D = (By.XPATH, '//td[contains(text(), "{label}")]//following-sibling::td[contains(text(), "{value}")]')
    CHECKBOX_PAID_S = (By.NAME, 'paid')
    CHECKBOX_CONFIRMED_S = (By.NAME, 'confirmed')
    CHECKBOX_CONFIRMATION_EMAIL_S = (By.NAME, 'confirmation_email')
    BUTTON_SEND_RESERVATION_S = (By.XPATH, '//button[@value="Zarezerwuj"]')
    TEXT_TICKET_TYPE_D = (By.XPATH,
                          '//div[@class="seat_name" and contains(text(), "{seat}")]//following-sibling::div[@class="ticket_type" and contains(text(), "{ticket}")]')
    TEXT_TOTAL_PRICE_S = (By.ID, 'total_price')

    def fill_out_third_tab_send_reservation(self, is_paid: bool, is_confirmed: bool, confirmation_email: bool):
        if is_paid:
            self._click_paid_checkbox()
        if is_confirmed:
            self._click_confirmed_checkbox()
        if confirmation_email:
            self._click_confirmation_email_checkbox()

        return self._send_reservation()

    @allure.step("Check summary")
    def check_summary(self, label: str, value: str) -> bool:
        """
        Checks data from previous tab in summary table.

        :param label: field label
        :param value: field value
        :return: True or false
        """
        return self.is_element_on_page(self.dynamic_locator(self.TEXT_SUMMARY_D, label=label, value=value))

    @allure.step("Check ticket type")
    def check_ticket_type(self, seat_label: str, ticket_type_name: str):
        return self.is_element_on_page(
            self.dynamic_locator(self.TEXT_TICKET_TYPE_D, seat=seat_label, ticket=ticket_type_name))

    @allure.step("Click 'reservation paid' checkbox")
    def _click_paid_checkbox(self):
        self.wait_and_click(self.CHECKBOX_PAID_S)

    @allure.step("Click 'reservation confirmed' checkbox")
    def _click_confirmed_checkbox(self):
        self.wait_and_click(self.CHECKBOX_CONFIRMED_S)

    @allure.step("Click 'send confirmation email' checkbox")
    def _click_confirmation_email_checkbox(self):
        self.wait_and_click(self.CHECKBOX_CONFIRMATION_EMAIL_S)

    @allure.step("Check total price")
    def check_total_price(self, total_price: str):
        return total_price.replace('.', ',') in self.get_text(self.TEXT_TOTAL_PRICE_S)

    @allure.step("Send reservation and redirect to film show details")
    def _send_reservation(self):
        """
        Send reservation and redirect to film show details

        :return: film show details page.
        """
        import pom.worker.pages.film_show.film_show_details as film_show_details

        self.wait_and_click(self.BUTTON_SEND_RESERVATION_S)
        return film_show_details.FilmShowDetailsP(self.driver)
