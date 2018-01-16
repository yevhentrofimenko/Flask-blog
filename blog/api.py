from flask import request, abort
from flask_restful import Resource, Api, reqparse, fields, marshal_with
from .models import Posts, Comments
from blog import app, db

api = Api(app)


def PostView(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title',
                                 type=str,
                                 required=True,
                                 help='No title provided',
                                 location='json')
        self.parser.add_argument('content',
                                 type=str,
                                 required=True,
                                 help='No content provided',
                                 location='json')
        self.parser.add_argument('user_id',
                                 type=int,
                                 required=True,
                                 location='json')

    post_fields = {
        'id': fields.Integer,
        'title': fields.String,
        'content': fields.String,
        'user_id': fields.Integer
    }

    @marshal_with(post_fields)
    def get(self, post_id):
        post = Posts.query.get(post_id)

        if not post:
            abort(404, "That id doesnt exist in database")

        return post

    @marshal_with(post_fields)
    def post(self):
        args = self.parser.parse_args()

        post = Posts(title=args['title'],
                     content=args['content'],
                     user_id=args['user_id'])

        db.session.add(post)
        db.session.commit()

        return post


api.add_resource(PostView,
                 '/post/',
                 '/post/<int:post_id>')