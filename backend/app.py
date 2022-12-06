from flask import Flask, jsonify, request
import os
import configparser
import Moodie.backend.database.db as DB

config = configparser.ConfigParser()
#print(os.path.abspath(os.path.join("data.ini")))
config.read(os.path.abspath(os.path.join("data.ini")))

app = Flask(__name__)

@app.route("/")
def sample():
   return "Hello, backend!"



@app.route('/id/<id>', methods=['GET'])
def api_get_movie_by_id(id):
       movie = DB.get_movie(id)
       
       return jsonify(
            {
                "movie": movie,
            }
        )

@app.route('/user/movie', methods=["POST"])
def api_add_user():
       user = request.args.get('user')
       passw = request.args.get('pass')
       email = request.args.get('email')
       
       return DB.add_user(user, passw, email)

@app.route('/user/movie', methods=["POST"])
def api_add_movie_to_user():
       id = request.args.get('id')
       user = request.args.get('user')
       
       return DB.add_movie_to_user(id,user)
       
@app.route('/user/movie', methods=["DELETE"])
def api_remove_movie_from_user():
       id = request.args.get('id')
       user = request.args.get('user')
       
       return DB.remove_movie_from_user(id,user)

@app.route('/movies/rand', methods=["GET"])
def api_get_random_movie():
       genre = request.args.get('genre')
    
@app.route('/rating/<value>', methods=["POST"])
def add_rating(rating):
       id = request.args.get('id')
       user = request.args.get('user')
       
       return DB.update_rating(rating, id, user)

@app.route('/rating/<value>', methods=["PUT"])
def update_rating(rating):
       id = request.args.get('id')
       user = request.args.get('user')
       
       return DB.update_rating(rating, id, user)
  
if __name__ == '__main__':
   app.config['DEBUG'] = True
   app.config['MONGO_URI'] = config['PROD']['DB_URI']
   app.run(host="0.0.0.0")