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

def add_movie(id,name,genre,year,duration,moods,rt_rating,imdb_rating,desc,trailer_link,poster_link):
    movie = { "movie_id" : id,
            "name" : name ,
            "genre" : genre,
            "year" : year,
            "duration" : duration,
            "rating" : (rt_rating+imdb_rating)/2,
            "description" : desc,
            "trailer" : trailer_link,
            "poster" : poster_link,
            "mood" : moods
            }
    return db.movies.insert_one(movie)

def aggregate_filters(filters):
    query={}
    
    if "genre" in filters:
        query["genre"] = { "$in": filters["genre"] }
    
    if "year" in filters:
        query["year"] = filters["year"]
    
    if "mood" in filters:
        query["mood"] = { "$in": filters["moods"] }
    
    if "rating" in filters:
        query["rating"] = { "$gte": filters["rating"] }
    
    return db.movies.aggregate([
        { "$match": query },
        { "$sample": { "size": 1 } } 
    ])


def get_random_movie(filters):
    
    movie = aggregate_filters(filters)
    
    return movie

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