import configparser
import os

if os.environ.get('env') == 'staging':
    environment = 'staging'
elif os.environ.get('env') == 'production':
    environment = 'production'
else:
    environment = None

config = configparser.ConfigParser()
config.read('config.ini')

EMAIL_LOGIN = os.environ.get('email_login')
EMAIL_PASSWD = os.environ.get('email_passwd')
EMAIL_HOST = os.environ.get('email_host')
EMAIL_PORT = os.environ.get('email_port')

SELENIUM_HUB_URL = config['global']['SELENIUM_HUB_URL']
APP_URL = config[environment]['APP_URL']
ADMIN_LOG = config[environment]['ADMIN_LOG']
ADMIN_PASS = config[environment]['ADMIN_PASS']
STAFF_ADMIN_LOG = config[environment]['STAFF_ADMIN_LOG']
STAFF_ADMIN_PASS = config[environment]['STAFF_ADMIN_PASS']
WORKER_LOG = config[environment]['WORKER_LOG']
WORKER_PASS = config[environment]['WORKER_PASS']

# main project dir
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))

# image file to upload
IMG_FILE = os.path.join(CURRENT_DIR, 'utils', 'movie_image.png')
