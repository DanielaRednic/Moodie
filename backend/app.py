from flask import Flask
import os
import configparser

config = configparser.ConfigParser()
#print(os.path.abspath(os.path.join("data.ini")))
config.read(os.path.abspath(os.path.join("data.ini")))

app = Flask(__name__)

@app.route("/")
def sample():
   return "Hello, backend!"
  
if __name__ == '__main__':
   app.config['DEBUG'] = True
   app.config['MONGO_URI'] = config['PROD']['DB_URI']
   app.run(host="0.0.0.0")