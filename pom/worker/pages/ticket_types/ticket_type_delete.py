import allure
from selenium.webdriver.common.by import By

from pom.worker.pages.top_menu import TopMenuP


class TicketTypeDeleteP(TopMenuP):
    TEXT_SECTION_HEADING_S = (By.TAG_NAME, 'h1')
    BUTTON_YES_S = (By.XPATH, '//input[@value="Tak"]')
    BUTTON_NO_S = (By.XPATH, '//a[contains(text(), "Nie")]')

    @allure.step("Check if ticket type name is in heading.")
    def check_ticket_type_name(self, type_name: str) -> bool:
        """
        Check if ticket type name is in heading.

        :param type_name: ticket type name
        :return: True or false.
        """
        return type_name in self.get_text(self.TEXT_SECTION_HEADING_S)

    @allure.step("Confirm ticket type deletion")
    def delete_ticket_type(self):
        """
        click "yes" button.

        :return: List page
        """
        import pom.worker.pages.ticket_types.list_page as list_page
        self.wait_and_click(self.BUTTON_YES_S)
        return list_page.ActiveTicketTypesListP(self.driver)

    @allure.step("Abandon ticket type delete form")
    def exit_form_without_deletion(self):
        """
        click "no" button.

        :return: Ticket type details.
        """
        import pom.worker.pages.ticket_types.ticket_type_details as ticket_type_details

        self.wait_and_click(self.BUTTON_NO_S)
        return ticket_type_details.TicketTypeDetailsP(self.driver)
