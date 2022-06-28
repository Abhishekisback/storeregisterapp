from flask import Flask, request , session
from datetime import datetime
from pymongo import MongoClient
from pymongo import MongoClient
from flask_cors import CORS, cross_origin
app = Flask(__name__)
CORS(app)
app.secret_key = "testing"

client = MongoClient('mongodb://localhost:27017/')
db = client['shopapp']
customers = db['customers']
stores = db['stores']
products = db['products']
categories = db['categories']


