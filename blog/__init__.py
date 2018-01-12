from flask_sqlalchemy import SQLAlchemy
from config import config
from flask_restful import Api
import os
from flask import Flask
from blog.recources.Comments import TodoList, Todo

app = Flask(__name__)
env = os.environ.get('FLASK_ENV', 'dev')
app.config.from_object(config[env])

api = Api(app)
api.add_resource(TodoList, '/todos')
api.add_resource(Todo, '/todos/<todo_id>')

db = SQLAlchemy(app)
db.create_all()
db.session.commit()

from blog.views import main

app.register_blueprint(main.mod)


