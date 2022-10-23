from flask import current_app, g
from flask_pymongo import PyMongo
from werkzeug.local import LocalProxy

def get_db():
    """
    Configuration method to return db instance
    """
    db = getattr(g, "_database", None)

    if db is None:

        db = g._database = PyMongo(current_app).db
       
    return db

db = LocalProxy(get_db)

def add_user(username, password, email):
    user = {}
    return db.users.insert_one(user)

def get_movie(id):
    query_movie = { "id" : id}
    return db.movies.find_one(query_movie, {})