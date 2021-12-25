from selenium.webdriver.common.by import By
from pom.base.checks import Assertions
from pom.client.pages.top_menu import TopMenuP


class PriceListP(TopMenuP):
    TEXT_COLUMN_HEADER_S = (By.XPATH, '//th[@scope="col"]')
    TEXT_TABLE_ROW_TICKET_DATA_D = (By.XPATH,
                                    '//tr/td/strong[contains(text(), "{type_name}")]/../following-sibling::td/strong[contains(text(), "{price}")]')
    TEXT_TICKET_TYPE_DESCRIPTION_D = (By.XPATH,
                                      '//div[@class="card-body"]//div[@class="ticket" and contains(text(), "{}")]')

    def get_column_names(self):
        """
        Returns column names

        :return: list of column names
        """
        return [column.text.strip() for column in self.driver.find_elements(*self.TEXT_COLUMN_HEADER_S)]

    def check_data_in_table(self, type_name: str, type_price: str) -> bool:
        """
        Return True if row with given ticket type and price exists in table.


        :param type_name: ticket type name
        :param type_price: ticket type price
        :return: True or false
        """
        return Assertions.is_element_on_page(self.driver, self.dynamic_locator(self.TEXT_TABLE_ROW_TICKET_DATA_D,
                                                                               type_name=type_name,
                                                                               price=type_price))

    def check_ticket_type_details(self, type_name: str, type_description: str) -> bool:
        """
        Return True if element with given text content exists.

        :param type_name: ticket type name
        :param type_description: ticket type description
        :return: True or false
        """
        full_description = type_name + ' - ' + type_description
        return Assertions.is_element_on_page(self.driver, self.dynamic_locator(self.TEXT_TICKET_TYPE_DESCRIPTION_D,
                                                                               full_description))
