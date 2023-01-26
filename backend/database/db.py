from flask import current_app, jsonify, g
import pymongo
from werkzeug.local import LocalProxy

def get_db():
    """
    Configuration method to return db instance
    """
    db = getattr(g, "_database", None)

    if db is None:
        db = g._database = pymongo.MongoClient(host=current_app.config.get("MONGO_URI", None)).msa
       
    return db

db = LocalProxy(get_db)

def add_user(username, password, email):
    user = {"username": username,
            "password": password,
            "email": email,
            "movies":[]}
    db.users.insert_one(user)
    return jsonify({"return": True})

def search_user(username=None, email = None):
    if email is None:
        query = {"username": username}
        return db.users.find_one(query,{})
    else:
        query = { "$or":[
            {"username":username},
            {"email":email}
        ]}
        return db.users.find_one(query,{"username":1,"password":1})
    
def get_details(userOrmail):
    query = { "$or":[
            {"username":userOrmail},
            {"email":userOrmail}
        ]}
    
    return db.users.find_one(query,{"username":1,"email":1})

def get_email(username):
    return db.users.find_one({"username": username},{"email":1})

def get_user_movies(username):
    return db.users.find_one({"username": username},{"movies":1})

def get_user_movies_ids(username):
    return db.users.find_one({"username": username},{"movies.movie_id":1})

def get_list_movies(ids):
    query={}
    
    query["movie_id"]= { "$in": ids }
    print(query)
    return db.movies.find(query,{"poster": 1,"year":1,"name":1,"movie_id":1})

def add_movie(name,genre,year,duration,moods,rt_rating,imdb_rating,desc,trailer_link,poster_link):
    movie = { "movie_id" : db.movies.count_documents({})+1,
            "name" : name ,
            "genre" : genre,
            "year" : int(year),
            "duration" : int(duration),
            "rating" : round((float(rt_rating)/10+float(imdb_rating))/2,1),
            "rotten": float(rt_rating),
            "imdb": float(imdb_rating),
            "description" : desc,
            "trailer" : trailer_link,
            "poster" : poster_link,
            "mood" : moods
            }
    db.movies.insert_one(movie)
    
    return jsonify({"return": True})

def aggregate_filters(filters):
    query={}
    if "ids" in filters:
        ids = filters["ids"]
        query["movie_id"] = { "$not": {"$in": ids}}
    if "genre" in filters:
        genre=filters["genre"]
        query["genre"] = { "$in": genre }
    
    if "year" in filters:
        years=filters["year"]
        query["year"] = { "$in": years }
    
    if "moods" in filters:
        mood=filters["moods"]
        query["mood"] = { "$in": mood }
    
    if "rating" in filters:
        query["rating"] = { "$gte": filters["rating"] }
    
    if "duration" in filters:
        
        if filters["duration"] == 'under 1.5 hours':
            query["duration"] = {"$lte": 90 }
        elif filters["duration"] == 'over 1.5 hours':
            query["duration"] = {"$gte": 90 }
        elif filters["duration"] == '1.5-2 hours':
            query["duration"] = {"$gte": 90, "lte": 120}
        elif filters["duration"] == 'over 2 hours':
            query["duration"] = {"$gte": 120}
        elif filters["duration"] == '2-3 hours':
            query["duration"] = {"$gte": 120, "lt": 180}
        elif filters["duration"] == 'over 3 hours':
            query["duration"] = {"$gte": 180}
    
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
    return db.movies.find(query_movie)

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
    db.users.update_one(query_user, 
                { "$set": 
                    { 
                     "movies.$.rating":float(rating) 
                    } 
                })
    
    return jsonify({"return": True})

def remove_movie_from_user(movie_id,username):
    query_user = { "username" : username}
    db.users.update_one(query_user, 
                { "$pull":{
                    "movies":{
                        "movie_id":movie_id
                        }
                    }
                } )
    
    return jsonify({"return": True})