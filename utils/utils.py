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
