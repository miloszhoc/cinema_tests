import allure
from selenium.webdriver.common.by import By
from pom.worker.pages.top_menu import TopMenuP


class TicketTypeAddFormP(TopMenuP):
    INPUT_TYPE_NAME_S = (By.NAME, 'type')
    INPUT_PRICE_S = (By.NAME, 'price')
    INPUT_CONDITIONS_S = (By.NAME, 'conditions')
    CHECKBOX_DELETED_S = (By.NAME, 'deleted')
    BUTTON_SAVE_S = (By.XPATH, '//button[@type="submit"]')

    @allure.step("Add ticket type and redirect to ticket types list.")
    def add_ticket_type(self, type_name: str, price: str, conditions: str,
                        deleted: bool):
        """
        Add ticket type and redirect to ticket types list.

        :return: ticket type list page.
        """
        self._type_ticket_type_name(type_name)
        self._type_price(price)
        self._type_conditions(conditions)

        self._check_deleted_checkbox() if deleted else None

        return self._click_save_button()

    @allure.step("Type ticket type name.")
    def _type_ticket_type_name(self, type_name: str) -> str:
        self.wait_and_type(self.INPUT_TYPE_NAME_S, type_name)
        return type_name

    @allure.step("Type ticket type price.")
    def _type_price(self, price: str) -> str:
        self.wait_and_type(self.INPUT_PRICE_S, price)
        return price

    @allure.step("Type ticket type conditions.")
    def _type_conditions(self, conditions: str) -> str:
        self.wait_and_type(self.INPUT_CONDITIONS_S, conditions)
        return conditions

    @allure.step("Check 'deleted' checkbox.")
    def _check_deleted_checkbox(self) -> bool:
        self.wait_and_click(self.CHECKBOX_DELETED_S)
        return True

    @allure.step("Save ticket type")
    def _click_save_button(self):
        import pom.worker.pages.ticket_types.ticket_type_details as ticket_type_details
        self.wait_and_click(self.BUTTON_SAVE_S)
        return ticket_type_details.TicketTypeDetailsP(self.driver)
