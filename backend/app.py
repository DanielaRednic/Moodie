from flask import Flask, jsonify, request
import os
import configparser
import re
import database.db as DB

config = configparser.ConfigParser()
#print(os.path.abspath(os.path.join("data.ini")))
config.read(os.path.abspath(os.path.join("data.ini")))

def password_check(password):
       SpecialSym =['$', '@', '#', '%','.',',','!','?']
       val = True
       
       if len(password) < 6:
              val = False
              
       if len(password) > 20:
              val = False
              
       if not any(char.isdigit() for char in password):
              val = False
              
       if not any(char.isupper() for char in password):
              val = False
              
       if not any(char.islower() for char in password):
              val = False
              
       if not any(char in SpecialSym for char in password):
              val = False
              
       return val

app = Flask(__name__)

@app.route("/")
def sample():
   return "Hello, backend!"

@app.route('/movies', methods=['GET'])
def api_get_movie_by_id(given_id=None):
       if given_id is None:
              id = request.args.get("id")
       else:
              id= given_id
              
       result = DB.get_movie(int(id))
       
       for movie in result:
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
       passw = request.form.get('pass')
       email = request.form.get('email')
       
       if(passw!=request.form.get('confirm_pass')):
              return jsonify({"error": "Passwords do not match",
                              "return": False})
       
       if(not(password_check(passw))):
              return jsonify({"error": "Password does not meet requirements",
                              "return": False})
              
       regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
       if(not(re.fullmatch(regex,email))):
              return jsonify({"error": "Email is invalid",
                              "return": False})
       
       if (DB.search_user(user,email)):
              return jsonify({"error": "User or Email already in use",
                              "return": False})
       
       return DB.add_user(user, passw.encode("UTF-8"), email)

@app.route('/user/verify', methods=["GET"])
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
       
       return DB.add_movie_to_user(int(id),user)
       
@app.route('/user/movie/delete', methods=["DELETE"])
def api_remove_movie_from_user():
       id = request.form.get('id')
       user = request.form.get('user')
       
       return DB.remove_movie_from_user(int(id),user)

@app.route('/movies/add', methods=["POST"])
def add_movie_to_db():
       id = request.form.get('id')
       name = request.form.get('name')
       genre = request.form.getlist('genre')
       year = request.form.get('year')
       duration = request.form.get('duration')
       moods = request.form.getlist('moods')
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
       
       return api_get_movie_by_id(int(movie_id))
       
    
@app.route('/rating', methods=["POST","PUT"])
def add_rating():
       rating = request.args.get("value")
       movie_id = request.form.get('id')
       user = request.form.get('user')
       
       return DB.update_rating(rating, int(movie_id), user)

# @app.route('/rating', methods=["PUT"])
# def update_rating():
#        rating = request.args.get("value")
#        movie_id = request.form.get('id')
#        user = request.form.get('user')
       
#        return DB.update_rating(rating, movie_id, user)
  
if __name__ == '__main__':
   app.config['DEBUG'] = True
   app.config['MONGO_URI'] = config['PROD']['DB_URI']
   app.run(host="0.0.0.0")