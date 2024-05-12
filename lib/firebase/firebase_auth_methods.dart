import 'dart:core';
import 'package:app/Screen/DataPage/data_page.dart';
import 'package:app/Screen/Login/login_screen.dart';
import 'package:app/firebase/fetch_vechicle_count.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';


import '../components/showSnackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      await sendEmailVerification(context);

      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(), // Replace NextScreen with your desired screen
        ),
      );
    } on FirebaseAuthException catch (e) {
        showSnackBar(context, e.message!);
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );


      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => VehicleDataFetcher() // Replace NextScreen with your desired screen
      //   ),
      // );

      // if the current user is not verified
      if (_auth.currentUser!.emailVerified) {
        
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => VehicleDataFetcher() // Replace NextScreen with your desired screen
        ),
      );
      } else {
        await sendEmailVerification(context);
        showSnackBar(context, "User not verified, check your Email");
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, "Email verification sent!");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // PHONE SIGN IN
  // Future<void> phoneSignIn(
  //   String phoneNumber
  //   BuildContext context,
  // ) async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await _auth.signInWithCredential(credential);
  //     },
  //     verificationFailed: (e) {
  //       showSnackBar(context, e.message!);
  //     },
  //     codeSent: ((String verificationId, int? resendToken) async  {
  //       showOTPDialog()
  //     }),
  //   );
  // }

  // // GOOGLE SIGN IN
  // Future<void> signInWithGoogle(BuildContext context) async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  //     if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
  //       // Create a new credential
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth?.accessToken,
  //         idToken: googleAuth?.idToken,
  //       );

  //       UserCredential userCredential = await _auth.signInWithCredential(credential);

  //       // if (userCredential.user != null) {
  //       //   if (userCredential.additionalUserInfo!.isNewUser) {
            
  //       //   }
  //       // }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!);
  //   }
  // }
}

