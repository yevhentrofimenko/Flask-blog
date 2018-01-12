import os


class Config:

    SECRET_KEY = 'testkey'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECURITY_REGISTERABLE = True
    SECURITY_PASSWORD_HASH = 'plaintext'
    SECURITY_POST_LOGIN_VIEW = '/blog'
    SECURITY_POST_REGISTER_VIEW = '/blog'
    SECURITY_SEND_REGISTER_EMAIL = False

class DevelopmentConfig(Config):
    SQLALCHEMY_DATABASE_URI = 'postgresql://testusr:password@127.0.0.1:5432/testdb'
    DEBUG = True


class ProductionConfig(Config):
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL')
    DEBUG = False


class DockerDevConfig(Config):
    SQLALCHEMY_DATABASE_URI = 'postgresql://testusr:password@postgres/testdb'
    DEBUG = True


config = {
    'dev': DevelopmentConfig,
    'prod': ProductionConfig,
    'docker': DockerDevConfig
}