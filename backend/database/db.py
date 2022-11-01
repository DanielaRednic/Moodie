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

def add_movie_to_user(movie_id,username):
    query_user = { "Username" : username}
    response = db.users.update_one(query_user, 
                { "$push": 
                    { "movies":
                        {
                            {"movie_id": movie_id,
                             "rating" : -1}
                        }
                    } 
                } )
    
    return response

def update_rating(rating,movie_id,username):
    query_user = { "Username" : username, "movies.movie_id":movie_id}
    response = db.users.update_one(query_user, 
                { "$set": 
                    { "movies.$.rating": rating } 
                } )
    
    return response

def remove_movie_from_user(movie_id,username):
    query_user = { "Username" : username}
    response = db.users.update_one(query_user, 
                { "$pull":{
                    "movies":{
                        "movie_id":movie_id
                        }
                    }
                } )
    
    return response