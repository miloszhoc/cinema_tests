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
    def get_current_datetime(days: float = 0, hours: float = 0, minutes: float = 0, seconds: float = 0) -> str:
        """
        :return: Current datetime in 'YY-MM-DD HH:MM' format
        """
        date = datetime.datetime.now() + datetime.timedelta(days=days, hours=hours, minutes=minutes, seconds=seconds)
        return datetime.datetime.strftime(date, '%Y-%m-%d %H:%M')

    @staticmethod
    def count_end_time(start_date: str, start_time: str, *args: str) -> str:
        """
        Counts end datetime.

        :param args: list of duration in 'HH:MM:SS' format
        :param start_date: date in DD.MM.YYYY
        :param start_time: time in HH:MM
        :return: calculated end time
        """
        start_datetime = datetime.datetime.strptime(start_date + ' ' + start_time, '%d.%m.%Y %H:%M')
        datetime.timedelta()
        end_time = start_datetime
        for duration in args:
            hours = float(duration.split(':')[0])
            minutes = float(duration.split(':')[1])
            seconds = float(duration.split(':')[2])
            end_time += datetime.timedelta(hours=hours, minutes=minutes, seconds=seconds)
        return datetime.datetime.strftime(end_time, '%d.%m.%Y %H:%M')
