import datetime


class DateUtils:
    @staticmethod
    def add_timestamp(text: str, sep: str = '_') -> str:
        """
        Function adds timestamp to string.

        :param sep: text separator
        :param text: timestamp will be appended to this text
        :return: New string
        """
        return '{}'.format(sep).join((text, str(datetime.datetime.now().timestamp()).split('.')[0]))

    @staticmethod
    def get_current_date() -> str:
        """
        :return: Current date in YY-MM-DD format
        """
        return datetime.datetime.strftime(datetime.datetime.now(), '%Y-%m-%d')

    @staticmethod
    def get_current_time() -> str:
        """
        :return: Current time in HH:MM format
        """
        return datetime.datetime.strftime(datetime.datetime.now(), '%H:%M')

    @staticmethod
    def get_current_datetime() -> str:
        """
        :return: Current datetime in 'YY-MM-DD HH:MM' format
        """
        return datetime.datetime.strftime(datetime.datetime.now(), '%Y-%m-%d %H:%M')
