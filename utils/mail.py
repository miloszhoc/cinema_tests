import imaplib

from env_data import EMAIL_HOST, EMAIL_PASSWD, EMAIL_LOGIN
import time


class Email:

    def __init__(self) -> None:
        super().__init__()
        self.__imap: imaplib.IMAP4_SSL = None

    def __open_connection(self):
        self.__imap = imaplib.IMAP4_SSL(EMAIL_HOST)
        self.__imap.login(EMAIL_LOGIN, EMAIL_PASSWD)
        self.__imap.select()

    def __close_connection(self):
        self.__imap.close()
        self.__imap.logout()

    def wait_open_email(self, email_title: str):
        """
        Waits for an unseen email with specific title and marks it as seen.

        :param email_title: full email title (or its part)
        :return: formatted mail content
        """
        self.__open_connection()
        counter = 10
        while counter:
            self.__imap.select()
            try:
                time.sleep(5)
                typ, data = self.__imap.uid('SEARCH', 'SUBJECT "{}"'.format(email_title), 'UNSEEN')
                result, mail_content = self.__imap.uid('FETCH', data[0], '(RFC822)')
            except self.__imap.error:
                counter -= 1
            else:
                mail_content = mail_content[0][1].decode('UTF-8')
                break

        self.__close_connection()
        return mail_content
