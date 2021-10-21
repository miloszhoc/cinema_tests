"""
Creating test data using requests

"""
import pytest
from env_data import IMG_FILE, EMAIL_LOGIN
from sql.sql_executor import execute_sql
from utils.requests.film_show_request import CreateFilmShow
from utils.requests.reservation_request import CreateReservation
from utils.utils import DateUtils
from sql import tickettype_sql


@pytest.fixture(scope='function')
def create_ticket_type():
    from utils.requests.ticket_type_request import CreateTicketType
    ticket = CreateTicketType()

    name = DateUtils.add_timestamp('ticket_type')
    price = '50'
    description = 'test description'
    deleted = False
    data = {'name': name,
            'price': price,
            'deleted': deleted,
            'description': description}
    ticket_type_id = ticket.create_ticket_type(name, price, description, deleted)
    data['ticket_type_id'] = ticket_type_id
    yield data
    execute_sql(tickettype_sql.DELETE_TICKETTYPE.format(data['ticket_type_id']))


@pytest.fixture(scope='function')
def create_inactive_ticket_type():
    from utils.requests.ticket_type_request import CreateTicketType
    ticket = CreateTicketType()

    name = DateUtils.add_timestamp('deleted_ticket_type')
    price = '50'
    description = 'deleted type description'
    deleted = True
    data = {'name': name,
            'price': price,
            'deleted': deleted,
            'description': description}
    ticket_type_id = ticket.create_ticket_type(name, price, description, deleted)
    data['ticket_type_id'] = ticket_type_id
    return data


@pytest.fixture(scope='function')
def create_movie():
    from utils.requests.movie_request import CreateMovie
    movie = CreateMovie()

    movie_title = DateUtils.add_timestamp('Test Movie')
    director = 'Test Director'
    release_year = '43'
    link = 'https://genius.com/Rick-astley-never-gonna-give-you-up-lyrics'
    thumbnail_file_path = IMG_FILE
    thumbnail_name = DateUtils.add_timestamp('image') + '.png'
    youtube_id = 'dQw4w9WgXcQ'
    duration = '1:15:00'
    description = 'test description'
    deleted = False

    data = {'title': movie_title,
            'director': director,
            'release_year': release_year,
            'link': link,
            'thumbnail_file_path': thumbnail_file_path,
            'thumbnail_name': thumbnail_name,
            'youtube_id': youtube_id,
            'duration': duration,
            'deleted': deleted,
            'description': description}
    movie_id = movie.create_movie(movie_title, director, release_year, description, link, thumbnail_file_path,
                                  thumbnail_name, youtube_id, deleted, duration)
    data['movie_id'] = movie_id
    return data


@pytest.fixture(scope='function')
def create_active_film_show(create_movie):
    film_show = CreateFilmShow()
    current_datetime = DateUtils.get_current_datetime()
    start_datetime = DateUtils.get_current_datetime(minutes=50)
    break_time = '00:05:00'

    data = {'current_date': current_datetime,
            'start_date': start_datetime,
            'break_time': break_time,
            'movie_title': create_movie['title'],
            'movie_data': create_movie}

    film_show_id = film_show.create_film_show(create_movie['movie_id'], start_datetime, current_datetime, break_time)
    data['film_show_id'] = film_show_id
    return data


@pytest.fixture(scope='function')
def create_archived_film_show(create_movie):
    film_show = CreateFilmShow()
    current_datetime = DateUtils.get_current_datetime()
    start_datetime = DateUtils.get_current_datetime(minutes=-180)
    break_time = '00:05:00'

    data = {'current_date': current_datetime,
            'start_date': start_datetime,
            'break_time': break_time,
            'movie_title': create_movie['title'],
            'movie_data': create_movie}

    film_show_id = film_show.create_film_show(create_movie['movie_id'], start_datetime, current_datetime, break_time)
    data['film_show_id'] = film_show_id
    return data


@pytest.fixture(scope='function')
def create_film_show_with_reservation(create_active_film_show, create_ticket_type):
    film_show = create_active_film_show
    ticket_type = create_ticket_type

    film_show_id = film_show['film_show_id']

    first_name = DateUtils().add_timestamp('John')
    last_name = 'Test'
    email = EMAIL_LOGIN
    phone_number = '456789123'
    paid = False
    confirmed = False
    confirmation_email = False

    data = {'movie_title': film_show['movie_title'],
            'ticket_type_name': ticket_type['name'],
            'first_name': first_name,
            'last_name': last_name,
            'email': email,
            'phone_number': phone_number,
            'paid': paid,
            'confirmed': confirmed,
            'confirmation_email': confirmation_email}

    reservation = CreateReservation()
    reservation.create_reservation(film_show_id, first_name, last_name, email, phone_number, paid, confirmed,
                                   confirmation_email, ticket_type['ticket_type_id'], '7')

    return data
