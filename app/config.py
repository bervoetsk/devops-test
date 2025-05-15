import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    SECRET_KEY = 'do-or-do-not-there-is-no-try'
#    SECRET_KEY = os.environ.get('SECRET_KEY') or 'do-or-do-not-there-is-no-try'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or 'postgresql-rds-1.c1pqtqrgaiq5.us-east-1.rds.amazonaws.com'
    SQLALCHEMY_TRACK_MODIFICATIONS = False