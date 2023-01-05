from flask import current_app, jsonify
from flask_pymongo.wrappers import MongoClient
from flask_pymongo import PyMongo
from werkzeug.local import LocalProxy

def get_db():
    """
    Configuration method to return db instance
    """
    client = MongoClient(current_app.config.get("MONGO_URI", None))
    db= client.msa
    return db

db = LocalProxy(get_db)

def add_user(username, password, email):
    user = {"username": username,
            "password": password,
            "email": email,
            "movies":[]}
    db.users.insert_one(user)
    return jsonify({"return": True})

def search_user(username, password = None):
    if password is None:
        query = {"username": username}
    else:
        query = {"username": username, "password": password}

    return db.users.find_one(query)

def search_email(email):
    query ={"email": email}
    
    return db.users.find_one(query)

def add_movie(id,name,genre,year,duration,moods,rt_rating,imdb_rating,desc,trailer_link,poster_link):
    movie = { "movie_id" : id,
            "name" : name ,
            "genre" : genre,
            "year" : year,
            "duration" : duration,
            "rating" : (int(rt_rating)+float(imdb_rating)*10)/2,
            "description" : desc,
            "trailer" : trailer_link,
            "poster" : poster_link,
            "mood" : moods
            }
    db.movies.insert_one(movie)
    
    return jsonify({"return": True})

def aggregate_filters(filters):
    query={}
    
    if "genre" in filters:
        genre=[filters["genre"]]
        query["genre"] = { "$in": genre }
    
    # if "year" in filters:
    #     query["year"] = filters["year"]
    
    # if "mood" in filters:
    #     mood=[filters["moods"]]
    #     query["mood"] = { "$in": mood }
    
    # if "rating" in filters:
    #     query["rating"] = { "$gte": filters["rating"] }
    
    print(query)
    return db.movies.aggregate([
        { "$match": query },
        { "$sample": { "size": 1 } } 
    ])


def get_random_movie(filters):
    
    movie = aggregate_filters(filters)
    
    return movie

def get_movie(id):
    query_movie = { "movie_id" : id}
    return db.movies.find_one(query_movie)

def add_movie_to_user(movie_id,username):
    query_user = { "username" : username}
    db.users.update_one(query_user, 
                        { "$push": 
                            { "movies":
                                {"movie_id": movie_id,
                                "rating" : -1}
                            } 
                        } )
    return jsonify({"return": True})

def update_rating(rating,movie_id,username):
    query_user = { "username" : username, "movies.movie_id":movie_id}
    print(db.users.find_one(query_user))
    response = db.users.update_one(query_user, 
                { "$set": 
                    { "movies":
                        {
                            "movie_id": movie_id,
                            "rating": rating 
                        } 
                    } 
                })
    
    return jsonify({"return": True})

def remove_movie_from_user(movie_id,username):
    query_user = { "username" : username}
    response = db.users.update_one(query_user, 
                { "$pull":{
                    "movies":{
                        "movie_id":movie_id
                        }
                    }
                } )
    
    return jsonify({"return": True})