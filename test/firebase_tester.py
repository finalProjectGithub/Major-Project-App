#-*- coding: utf-8 -*-
import time
import random
import firebase_admin
from firebase_admin import db, credentials

databaseURL = {"databaseURL" : "https://majordb-default-rtdb.firebaseio.com"}
cred = credentials.Certificate("credentials.json")
firebase_admin.initialize_app(cred, databaseURL)

ref = db.reference("/")

db.reference("/count").set(0)

while True:
    random_number = random.randint(0, 15)
    print(random_number)
    db.reference("/").update({"count" : random_number})
    time.sleep(1)