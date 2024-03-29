import string
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
              
       if not any(char.isdigit() for char in password):
              val = False
              
       if not any(char.isupper() for char in password):
              val = False
              
       if not any(char.islower() for char in password):
              val = False
              
       if not any(char in SpecialSym for char in password):
              val = False
              
       return val

def get_duration_string(duration):
       hours = int(duration)//60
       minutes = int(duration)%60
       
       time_string= "{}h {}m".format(hours,minutes)
       return time_string

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
                     "movie_id":movie["movie_id"],
                     "title": movie["name"],
                     "genre": movie["genre"],
                     "year": movie["year"],
                     "duration": get_duration_string(movie["duration"]),
                     "rating": movie["rating"],
                     "description": movie["description"],
                     "trailer": movie["trailer"],
                     "poster": movie["poster"],
                     "mood": movie["mood"],
                     "rt_rating": movie["rotten"],
                     "imdb": movie["imdb"],
                     "return": True
              }
              )

@app.route('/user/get/details', methods=["GET"])
def api_get_user_details():
       user = request.args.get('user')
       
       result = DB.get_details(user)
       
       if(result):
              return jsonify({
                     "username": result["username"],
                     "email":result["email"],
                     "return": True
              })
       
       return jsonify({
              "return": False
       })

@app.route('/user/get/email', methods=["GET"])
def api_get_email():
       user = request.args.get('user')
       
       result = DB.get_email(user)
       
       if(result):
              return jsonify({
                     "email":result["email"],
                     "return": True
              })
       
       return jsonify({
              "return": False
       })

@app.route('/user/get/movies', methods=["GET"])
def api_get_user_movies():
       user = request.args.get('user')
       
       result = DB.get_user_movies(user)
       if(result):
              list_ids=[]
              dict_movies_user={}
              for info in result["movies"]:
                     list_ids.append(info["movie_id"])
                     if(info["rating"]== -1):
                            info["rating"]= "N/A"
                     dict_movies_user[info["movie_id"]]=info["rating"]
              
              resulted_movies= DB.get_list_movies(list_ids)

              final_list=[]
              for movie in resulted_movies:
                     print(movie["name"])
                     print(dict_movies_user.get(movie["movie_id"]))
                     final_list.append(dict([
                            ("year",movie["year"]),
                            ("poster",movie["poster"]),
                            ("name",movie["name"]),
                            ("rating",dict_movies_user.get(movie["movie_id"])),
                            ("id",movie["movie_id"])
                     ]))
              return jsonify({
                     "movies":final_list,
                     "return": True
              })
       
       return jsonify({
              "return": False
       })

@app.route('/user/add', methods=["POST"])
def api_add_user():
       data = request.json
       user = data['user']
       passw = data['pass']
       email = data['email']
              
       regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
       if(not(re.fullmatch(regex,email))):
              return jsonify({"error": "Email is invalid",
                              "return": False})
       
       if (DB.search_user(user,email)):
              return jsonify({"error": "User or Email already in use",
                              "return": False})
       
       if(passw.encode("UTF-8")!=data['confirm_pass'].encode("UTF-8")):
              return jsonify({"error": "Passwords do not match",
                              "return": False})
       
       if(not(password_check(passw))):
              return jsonify({"error": "Password does not meet requirements!\nMust contain 1 uppercase letter, 1 number and 1 special symbol",
                              "return": False})
       
       return DB.add_user(user, passw.encode("UTF-8"), email)

@app.route('/user/verify', methods=["GET"])
def api_verify_user():
       user = request.args.get('user')
       passw = request.args.get('pass').encode("UTF-8")
       
       user = DB.search_user(username=user,email=user)
       
       if(user):
              if(user['password'] == passw):
                     return jsonify({"return":True})
              else:
                     return jsonify({"error": "Password is incorrect",
                                   "return": False})
       
       return jsonify({"error": "User not found",
                            "return": False})

@app.route('/user/movie/add', methods=["POST"])
def api_add_movie_to_user():
       data= request.json
       id = data['id']
       user = data['user']
       
       return DB.add_movie_to_user(int(id),user)
       
@app.route('/user/movie/delete', methods=["DELETE"])
def api_remove_movie_from_user():
       data= request.json
       id = data['id']
       user = data['user']
       
       return DB.remove_movie_from_user(int(id),user)

@app.route('/movies/add', methods=["POST"])
def add_movie_to_db():
       data = request.json
       
       return DB.add_movie(data["name"].title(),[x.lower() for x in data["genre"]],data["year"],data["duration"],[x.lower() for x in data["moods"]],data["rt_rating"],data["imdb_rating"], data["desc"],data["trailer_link"],data["poster_link"])

@app.route('/movies/rand', methods=["GET","POST"])
def api_get_random_movie():
       data = request.json
       print("Any movie:",data["anything"])
       
       ids=[]
       if(data["id"] !="0"):
              ids= list(data["id"][1:-1].split(","))
              for i in range(len(ids)):
                     ids[i]= int(ids[i][1:-1])
       
       if data["user"] != "Guest":
              results = DB.get_user_movies_ids(data["user"])
              for result in results["movies"]:
                     ids.append(result["movie_id"])
       
       if(data["anything"] == "true"):
              filters={}
              filters["ids"]= ids 
              result = DB.get_random_movie(filters)
              if(result):
                     for movie in result:
                            return jsonify(
                            {
                                   "movie_id":movie["movie_id"],
                                   "title": movie["name"],
                                   "genre": movie["genre"],
                                   "year": movie["year"],
                                   "duration": get_duration_string(movie["duration"]),
                                   "rating": movie["rating"],
                                   "description": movie["description"],
                                   "trailer": movie["trailer"],
                                   "poster": movie["poster"],
                                   "mood": movie["mood"],
                                   "rt_rating": movie["rotten"],
                                   "imdb": movie["imdb"],
                                   "return": True
                            }
                            )
              return jsonify({
                     "error": "No movie found",
                     "return": False
              })
             
       data_list= list(data["filters"][1:-1].split(","))
       
       for i in range(len(data_list)):
              data_list[i]= data_list[i][1:-1]
       
       
       moods = [
              'Adventurous',
              'Angry',
              'Bored',
              'Curious',
              'Depressed',
              'Evil',
              'Happy',
              'Mysterious',
              'Playful',
              'Romantic',
              'Sad',
              ]
       genres = [
              'Action',
              'Adventure',
              'Animation',
              'Comedy',
              'Documentary',
              'Drama',
              'Fantasy',
              'Horror',
              'Mystery',
              'Romantic',
              'Sci-Fi',
              'Superhero',
              'Thriller',
              ]
       
       ratings = [
              '10',
              '9.5',
              '9',
              '8.5',
              '8',
              '7.5',
              '7',
              '6.5',
              '6',
              '5.5',
              '5',
              '4.5',
              '4',
              'Less than 4',
       ]
       
       years = [
              '2023','2022','2021','2020','2019','2018','2017','2016','2015','2014','2013','2012',
              '2011','2010','2009','2008','2007','2006','2005','2004','2003','2002','2001','2000']

       durations = [
              'over 3 hours',
              '2-3 hours',
              'over 2 hours',
              '1.5-2 hours',
              'under 1.5 hours'
              ]
       
       filters = {}

       filters["ids"]= ids 
       for duration in durations:
              if duration in data_list:
                     filters["duration"]= duration
                     break
       
       for value in ratings:
              if value in data_list:
                     filters["rating"]= float(value)
                     
       
       genre_list=[]
       for genre in genres:
              if genre in data_list:
                     genre_list.append(str.lower(genre))
       
       year_list=[]
       for year in years:
              if year in data_list:
                     year_list.append(int(year))
       
       mood_list=[]
       for mood in moods:
              if mood in data_list:
                     mood_list.append(str.lower(mood))
       
       if len(genre_list) != 0:
              filters['genre']= genre_list
       
       if len(year_list) != 0:
              filters['year']= year_list
       
       if len(mood_list) != 0:
              filters["moods"]= mood_list
       
       print("Filters:\n",filters)
       result = DB.get_random_movie(filters)
       if(result):
              for movie in result:
                     return jsonify(
                     {
                            "movie_id":movie["movie_id"],
                            "title": movie["name"],
                            "genre": movie["genre"],
                            "year": movie["year"],
                            "duration": get_duration_string(movie["duration"]),
                            "rating": movie["rating"],
                            "description": movie["description"],
                            "trailer": movie["trailer"],
                            "poster": movie["poster"],
                            "mood": movie["mood"],
                            "rt_rating": movie["rotten"],
                            "imdb": movie["imdb"],
                            "return": True
                     }
                     )
       return jsonify({
              "error": "No movie found",
              "return": False
       })
    
@app.route('/rating', methods=["POST","PUT"])
def add_rating():
       rating = request.args.get("value")
       data= request.json
       movie_id = data['id']
       user = data['user']
       
       return DB.update_rating(int(rating), int(movie_id), user)

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