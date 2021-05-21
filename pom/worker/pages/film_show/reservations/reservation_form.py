from selenium.webdriver.common.by import By

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


class ReservationAddForm2ndTabP(TopMenuP):
    TEXT_SUMMARY_D = (By.XPATH, '//td[contains(text(), "{label}")]//following-sibling::td[contains(text(), "{value}")]')
    BUTTON_NEXT_S = (By.XPATH, '//button[@value="Dalej"]')

    def check_summary(self, label: str, value: str) -> bool:
        """
        Checks data from previous tab in summary table.

        :param label: field label
        :param value: field value
        :return: True or false
        """
        return self.is_element_on_page(self.dynamic_locator(self.TEXT_SUMMARY_D, label=label, value=value))

    def choose_ticket_type(self, seat_label: str, ticket_type_name: str):
        pass
        # todo

    def click_next_button(self):
        self.wait_and_click(self.BUTTON_NEXT_S)


class ReservationAddForm3rdTabP(TopMenuP):
    TEXT_SUMMARY_D = (By.XPATH, '//td[contains(text(), "{label}")]//following-sibling::td[contains(text(), "{value}")]')
    CHECKBOX_PAID_S = (By.NAME, 'paid')
    CHECKBOX_CONFIRMED_S = (By.NAME, 'confirmed')
    CHECKBOX_CONFIRMATION_EMAIL_S = (By.NAME, 'confirmation_email')
    BUTTON_SEND_RESERVATION_S = (By.XPATH, '//button[@value="Zarezerwuj"]')

    def check_summary(self, label: str, value: str) -> bool:
        """
        Checks data from previous tab in summary table.

        :param label: field label
        :param value: field value
        :return: True or false
        """
        return self.is_element_on_page(self.dynamic_locator(self.TEXT_SUMMARY_D, label=label, value=value))

    def check_ticket_type(self, seat_label: str, ticket_type_name: str):
        pass
        # todo check ticket types

    def click_paid_checkbox(self):
        self.wait_and_click(self.CHECKBOX_PAID_S)

    def click_confirmed_checkbox(self):
        self.wait_and_click(self.CHECKBOX_CONFIRMED_S)

    def click_confirmation_email_checkbox(self):
        self.wait_and_click(self.CHECKBOX_CONFIRMATION_EMAIL_S)

    def send_reservation(self):
        """
        Send reservation and redirect to film show details

        :return: film show details page.
        """
        import pom.worker.pages.film_show.film_show_details as film_show_details

        self.wait_and_click(self.BUTTON_SEND_RESERVATION_S)
        return film_show_details.FilmShowDetailsP(self.driver)
