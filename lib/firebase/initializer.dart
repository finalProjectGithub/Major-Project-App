import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

// Initialize the Firebase app instance.
final Future<FirebaseApp> firebaseAppInstsance = Firebase.initializeApp();

// Instance of firebase Real time database
FirebaseDatabase database = FirebaseDatabase.instance;

// reference variable for firebase real time database
// change the string inside ref() to initialize a different key-value pair
DatabaseReference ref= FirebaseDatabase.instance.ref('count');