"""
Creating test data using requests

"""
import pytest
from env_data import IMG_FILE
from utils.film_show_request import CreateFilmShow
from utils.utils import DateUtils


@pytest.fixture(scope='function')
def create_ticket_type():
    from utils.ticket_type_request import CreateTicketType
    ticket = CreateTicketType()

    name = DateUtils.add_timestamp('ticket_type')
    price = '50'
    description = 'test description'
    deleted = False
    data = {'name': name,
            'price': price,
            'deleted': deleted,
            'description': description}
    ticket.create_ticket_type(name, price, description, deleted)

    return data


@pytest.fixture(scope='function')
def create_movie():
    from utils.movie_request import CreateMovie
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

    data = {'film_show': film_show,
            'current_date': current_datetime,
            'start_date': start_datetime,
            'break_time': break_time}

    film_show.create_film_show(create_movie['movie_id'], start_datetime, current_datetime, break_time)
    return data
