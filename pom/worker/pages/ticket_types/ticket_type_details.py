from selenium.webdriver.common.by import By

from pom.worker.pages.top_menu import TopMenuP
import pom.worker.pages.ticket_types.ticket_type_delete as ticket_type_delete


class TicketTypeDetailsP(TopMenuP):
    HREF_UPDATE_TICKET_TYPE_S = (By.LINK_TEXT, 'Aktualizuj informacje o typie biletu')
    HREF_DELETE_TICKET_TYPE_S = (By.LINK_TEXT, 'Usuń typ biletu')
    TEXT_FIELD_NAME_VALUE_D = (By.XPATH,
                               '//div[@class="name"]/b[contains(text(), "{name}")]//..//../div[contains(text(), "{value}")]')

    def open_update_ticket_type_form(self):
        import pom.worker.pages.ticket_types.ticket_type_form as ticket_type_form

        self.wait_and_click(self.HREF_UPDATE_TICKET_TYPE_S)
        return ticket_type_form.TicketTypeAddFormP(self.driver)

    def open_delete_ticket_type_page(self) -> ticket_type_delete.TicketTypeDeleteP:
        self.wait_and_click(self.HREF_DELETE_TICKET_TYPE_S)
        return ticket_type_delete.TicketTypeDeleteP(self.driver)
