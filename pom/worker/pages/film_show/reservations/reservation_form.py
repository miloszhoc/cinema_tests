from selenium.webdriver.common.by import By
from selenium.webdriver.support.select import Select

from pom.worker.pages.top_menu import TopMenuP


class ReservationAddForm1stTabP(TopMenuP):
    INPUT_NAME_S = (By.NAME, 'first_name')
    INPUT_LAST_NAME_S = (By.NAME, 'last_name')
    INPUT_EMAIL_S = (By.NAME, 'last_name')
    INPUT_PHONE_S = (By.NAME, 'phone_number')
    CHECKBOX_SEAT_D = (By.XPATH, '//label[contains(text(), "{}")]//input[@type="checkbox"]')
    BUTTON_NEXT_S = (By.XPATH, '//button[@value="Dalej"]')

    def type_name(self, name: str) -> str:
        self.wait_and_type(self.INPUT_NAME_S, name)
        return name

    def type_last_name(self, last_name: str) -> str:
        self.wait_and_type(self.INPUT_LAST_NAME_S, last_name)
        return last_name

    def type_email(self, email: str) -> str:
        self.wait_and_type(self.INPUT_EMAIL_S, email)
        return email

    def type_phone_number(self, number: str) -> str:
        self.wait_and_type(self.INPUT_EMAIL_S, number)
        return number

    def choose_seat(self, seat: str) -> str:
        """
        Check seat.

        :param seat: seat code (e.g. A1)
        :return: seat code
        """
        self.wait_and_click(self.dynamic_locator(self.CHECKBOX_SEAT_D, seat))
        return seat

    def click_next_button(self):
        self.wait_and_click(self.BUTTON_NEXT_S)
        return ReservationAddForm2ndTabP(self.driver)


class ReservationAddForm2ndTabP(TopMenuP):
    TEXT_SUMMARY_D = (By.XPATH, '//td[contains(text(), "{label}")]//following-sibling::td[contains(text(), "{value}")]')
    BUTTON_NEXT_S = (By.XPATH, '//button[@value="Dalej"]')
    SELECT_TICKET_TYPE_D = (By.XPATH,
                            '//option[contains(text(), "{}") and @selected]/../../../following-sibling::div[contains(@id, "tickettype_id")]//select')

    def check_summary(self, label: str, value: str) -> bool:
        """
        Checks data from previous tab in summary table.

        :param label: field label
        :param value: field value
        :return: True or false
        """
        return self.is_element_on_page(self.dynamic_locator(self.TEXT_SUMMARY_D, label=label, value=value))

    def choose_ticket_type(self, seat_label: str, ticket_type_name: str) -> dict:
        """

        Choose ticket type for a seat.

        :param seat_label: seat label (e.g. A1)
        :param ticket_type_name: ticket type name
        :return: dict (seat_label: ticket_type_name)
        """
        Select(self.driver.find_element(
            *self.dynamic_locator(self.SELECT_TICKET_TYPE_D, seat_label))).select_by_visible_text(ticket_type_name)
        return {seat_label: ticket_type_name}

    def click_next_button(self):
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

    def click_paid_checkbox(self):
        self.wait_and_click(self.CHECKBOX_PAID_S)

    def click_confirmed_checkbox(self):
        self.wait_and_click(self.CHECKBOX_CONFIRMED_S)

    def click_confirmation_email_checkbox(self):
        self.wait_and_click(self.CHECKBOX_CONFIRMATION_EMAIL_S)

    def get_total_price(self, total_price: str):
        return total_price.replace('.', ',') in self.TEXT_TOTAL_PRICE_S

    def send_reservation(self):
        """
        Send reservation and redirect to film show details

        :return: film show details page.
        """
        import pom.worker.pages.film_show.film_show_details as film_show_details

        self.wait_and_click(self.BUTTON_SEND_RESERVATION_S)
        return film_show_details.FilmShowDetailsP(self.driver)
