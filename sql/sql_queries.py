DELETE_CLIENT = '''DELETE FROM worker_client WHERE client_id={};'''
DELETE_FILM_SHOW = '''DELETE FROM worker_showtime WHERE showtime_id={};'''
DELETE_MOVIE = '''DELETE FROM worker_movie WHERE movie_id={};'''
DELETE_RESERVATION = '''DELETE FROM worker_reservation WHERE reservation_id={};'''
DELETE_RESERVATION_TICKET = '''DELETE FROM worker_reservation_ticket_id WHERE id={};'''
DELETE_TICKET = '''DELETE FROM worker_ticket WHERE ticket_id={};'''
DELETE_TICKETTYPE = '''DELETE FROM worker_tickettype WHERE ticket_id={};'''

# todo rename to more friendly name
SELECT_IDS = '''
    SELECT wr.reservation_id, wr.client_id_id, wrti.ticket_id, wr.showtime_id_id, wrti.id
FROM worker_reservation AS wr
         JOIN worker_reservation_ticket_id AS wrti ON wr.reservation_id = wrti.reservation_id
         JOIN worker_ticket AS wt ON wrti.ticket_id = wt.ticket_id
WHERE wr.showtime_id_id = {};'''
