import allure
from selenium.webdriver.common.by import By
from selenium.webdriver.support.select import Select
from pom.worker.pages.top_menu import TopMenuP


class ReservationUpdateFormP(TopMenuP):
    INPUT_FIRST_NAME_S = (By.NAME, 'first_name')
    INPUT_LAST_NAME_S = (By.NAME, 'last_name')
    INPUT_EMAIL_S = (By.NAME, 'email')
    INPUT_PHONE_NUMBER_S = (By.NAME, 'phone_number')
    CHECKBOX_PAID_S = (By.NAME, 'paid')
    CHECKBOX_CONFIRMED_S = (By.NAME, 'confirmed')
    CHECKBOX_CONFIRMATION_EMAIL_S = (By.NAME, 'confirmation_email')
    SELECT_SEAT_D = (By.XPATH, '//div[@class="multiField"][{form_number}]//select[contains(@name, "seat_id")]')
    SELECT_TICKET_TYPE_D = (By.XPATH,
                            '//div[@class="multiField"][{form_number}]//select[contains(@name, "tickettype_id")]')
    BUTTON_SEND_UPDATE_FORM_S = (By.XPATH, '//button[@value="Zatwierdź"]')

    SELECT_TICKET_NUMBER_S = (By.NAME, 'ticket_select')
    BUTTON_ADD_TICKETS_S = (By.XPATH, '//button[@value="Dodaj"]')

    @allure.step("Select seat and ticket type")
    def select_seat_and_ticket_type(self, form_number: int, seat_name: str, ticket_type_name: str):
        """
        Set seats and ticket types for tickets in reservation

        :param form_number:
        :param seat_name: seat name (e.g. A1)
        :param ticket_type_name: ticket type name
        :return: None
        """
        select_seat = Select(
            self.driver.find_element(*self.dynamic_locator(self.SELECT_SEAT_D, form_number=form_number)))
        select_seat.select_by_visible_text(seat_name)

        select_ticket_type = Select(
            self.driver.find_element(*self.dynamic_locator(self.SELECT_TICKET_TYPE_D, form_number=form_number)))
        select_ticket_type.select_by_visible_text(ticket_type_name)

    @allure.step("Type name")
    def _type_name(self, name: str) -> str:
        self.wait_and_type(self.INPUT_FIRST_NAME_S, name)
        return name

    @allure.step("Type last name")
    def _type_last_name(self, last_name: str) -> str:
        self.wait_and_type(self.INPUT_LAST_NAME_S, last_name)
        return last_name

    @allure.step("Type email")
    def _type_email(self, email: str) -> str:
        self.wait_and_type(self.INPUT_EMAIL_S, email)
        return email

    @allure.step("Type phone number")
    def _type_phone_number(self, number: str) -> str:
        self.wait_and_type(self.INPUT_PHONE_NUMBER_S, number)
        return number

    @allure.step("Click 'paid' checkbox")
    def _click_paid_checkbox(self):
        self.wait_and_click(self.CHECKBOX_PAID_S)

    @allure.step("Click 'confirmed' checkbox")
    def _click_confirmed_checkbox(self):
        self.wait_and_click(self.CHECKBOX_CONFIRMED_S)

    @allure.step("Click 'send confirmation email' checkbox")
    def _click_confirmation_email_checkbox(self):
        self.wait_and_click(self.CHECKBOX_CONFIRMATION_EMAIL_S)

    @allure.step("Send update reservation form")
    def click_send_update_form_button(self):
        from pom.worker.pages.film_show.film_show_details import FilmShowDetailsP
        self.wait_and_click(self.BUTTON_SEND_UPDATE_FORM_S)
        return FilmShowDetailsP(self.driver)

    @allure.step("Set number of ticket reservation in form")
    def add_tickets(self, ticket_number: str):
        """
        Set number of ticket reservation in form

        :param ticket_number: number of tickets to add
        :return: None
        """
        select = Select(self.driver.find_element(*self.SELECT_TICKET_NUMBER_S))
        select.select_by_visible_text(ticket_number)

        self.wait_and_click(self.BUTTON_ADD_TICKETS_S)
