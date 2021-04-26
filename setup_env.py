import configparser
import os

if os.environ.get('env') == 'stage_env':
    environment = 'stage_env'
elif os.environ.get('env') == 'prod_env':
    environment = 'prod_env'
else:
    environment = None

config = configparser.ConfigParser()
config.read('../config.ini')

SELENIUM_HUB_URL = config[environment]['SELENIUM_HUB_URL']
APP_URL = config[environment]['APP_URL']
ADMIN_LOG = config[environment]['ADMIN_LOG']
ADMIN_PASS = config[environment]['ADMIN_PASS']
STAFF_ADMIN_LOG = config[environment]['STAFF_ADMIN_LOG']
STAFF_ADMIN_PASS = config[environment]['STAFF_ADMIN_PASS']
WORKER_LOG = config[environment]['WORKER_LOG']
WORKER_PASS = config[environment]['WORKER_PASS']
