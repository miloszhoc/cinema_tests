from selenium.webdriver.common.by import By
import pom.worker.pages.ticket_types.ticket_type_form as ticket_type_form

from pom.worker.pages.top_menu import TopMenuP

import pom.worker.pages.ticket_types.ticket_type_details as ticket_type_details


class TicketTypesListP(TopMenuP):
    TEXT_TABLE_HEADER_D = (By.XPATH, '//th[contains(text(), "{}")]')
    TEXT_LIST_TITLE_D = (By.XPATH, '//h3[contains(text(), "{}")]')
    HREF_TICKET_TYPE_DETAILS_D = (By.XPATH,
                                  '//td[contains(text(), "{}")]//following-sibling::td//a[contains(text(), "Przejdź do szczegółów")]')

    def open_ticket_type_details(self, type_name: str) -> ticket_type_details.TicketTypeDetailsP:
        """
        Open ticket type details.

        :param type_name:  ticket type name
        :return: Ticket type details page
        """
        print(self.dynamic_locator(self.HREF_TICKET_TYPE_DETAILS_D, type_name))
        self.wait_and_click(self.dynamic_locator(self.HREF_TICKET_TYPE_DETAILS_D, type_name))
        return ticket_type_details.TicketTypeDetailsP(self.driver)


class DeletedTicketTypesListP(TicketTypesListP):
    pass


class ActiveTicketTypesListP(TicketTypesListP):
    HREF_ADD_TICKET_TYPE_S = (By.LINK_TEXT, 'Dodaj typ biletu')
    HREF_DELETED_TICKET_TYPES_S = (By.LINK_TEXT, 'Usunięte typy biletów')

    def open_add_ticket_type_form(self) -> ticket_type_form.TicketTypeAddFormP:
        """
        Open new ticket type form.

        :return: Ticket type form.
        """
        self.wait_and_click(self.HREF_ADD_TICKET_TYPE_S)
        return ticket_type_form.TicketTypeAddFormP(self.driver)

    def open_deleted_ticket_types_list(self) -> DeletedTicketTypesListP:
        """
        Open deleted ticket types list.

        :return: Deleted ticket types list.
        """
        self.wait_and_click(self.HREF_DELETED_TICKET_TYPES_S)
        return DeletedTicketTypesListP(self.driver)
