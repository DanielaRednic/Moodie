from flask import Flask, jsonify, request
import os
import configparser
import database.db as DB

config = configparser.ConfigParser()
#print(os.path.abspath(os.path.join("data.ini")))
config.read(os.path.abspath(os.path.join("data.ini")))

app = Flask(__name__)

@app.route("/")
def sample():
   return "Hello, backend!"

@app.route('/movies', methods=['GET'])
def api_get_movie_by_id(given_id=None):
       if given_id==None:
              id = request.args.get("id")
       else:
              id= given_id
       movie = DB.get_movie(id)
       
       return jsonify(
            {
                "title": movie["name"],
                "genre": movie["genre"],
                "year": movie["year"],
                "duration": movie["duration"],
                "rating": movie["rating"],
                "description": movie["description"],
                "trailer": movie["trailer"],
                "poster": movie["poster"],
                "mood": movie["mood"]
            }
        )

@app.route('/user/add', methods=["POST"])
def api_add_user():
       user = request.form.get('user')
       passw = request.form.get('pass').encode("UTF-8")
       email = request.form.get('email')
       
       print(DB.search_user(user))
       if (DB.search_user(user)):
              return jsonify({"error": "User already exists",
                              "return": True})
       
       if(DB.search_email(email)):
              return jsonify({"error": "Email already in use",
                              "return": False})
       
       return DB.add_user(user, passw, email)

@app.route('/user/verify')
def api_verify_user():
       username = request.form.get('user')
       passw = request.form.get('pass').encode("UTF-8")
       
       user = DB.search_user(username)
       
       if(user):
              if(user['username'] == username and user['password'] == passw):
                     return jsonify({"return":True})
              else:
                     return jsonify({"error": "User or password incorrect",
                            "return": False})
       
       return jsonify({"error": "User not found",
                            "return": False})

@app.route('/user/movie/add', methods=["POST"])
def api_add_movie_to_user():
       id = request.form.get('id')
       user = request.form.get('user')
       
       return DB.add_movie_to_user(id,user)
       
@app.route('/user/movie/delete', methods=["DELETE"])
def api_remove_movie_from_user():
       id = request.form.get('id')
       user = request.form.get('user')
       
       return DB.remove_movie_from_user(id,user)

@app.route('/movies/add', methods=["POST"])
def add_movie_to_db():
       id = request.form.get('id')
       name = request.form.get('name')
       genre = request.form.get('genre')
       year = request.form.get('year')
       duration = request.form.get('duration')
       moods = request.form.get('moods')
       rt_rating = request.form.get('rt_rating')
       imdb_rating = request.form.get('imdb_rating')
       desc = request.form.get('desc')
       trailer_link = request.form.get('trailer_link')
       poster_link = request.form.get('poster_link')
       return DB.add_movie(id,name,genre,year,duration,moods,rt_rating,imdb_rating, desc,trailer_link,poster_link)

@app.route('/movies/rand', methods=["GET"])
def api_get_random_movie():
       genre = request.form.get('genre')
       year = request.form.get('year')
       mood = request.form.get('moods')
       rating = request.form.get('rating')
       
       filters = {}
       filters['genre'] = genre
       filters['year'] = year
       filters['moods'] = mood
       filters['rating'] = int(rating)
       
       result = DB.get_random_movie(filters)
       
       for movie in result:
              movie_id= movie['movie_id']
       
       return api_get_movie_by_id(movie_id)
       
    
@app.route('/rating', methods=["POST","PUT"])
def add_rating():
       rating = request.args.get("value")
       movie_id = request.form.get('id')
       user = request.form.get('user')
       
       return DB.update_rating(rating, movie_id, user)

# @app.route('/rating', methods=["PUT"])
# def update_rating():
#        rating = request.args.get("value")
#        movie_id = request.form.get('id')
#        user = request.form.get('user')
       
#        return DB.update_rating(rating, movie_id, user)
  
if __name__ == '__main__':
   app.config['DEBUG'] = True
   app.config['MONGO_URI'] = config['PROD']['DB_URI']
   print(app.config['MONGO_URI'])
   app.run(host="0.0.0.0")