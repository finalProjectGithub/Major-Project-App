import 'package:app/Screen/ForgotPassword/forgot_password_page.dart';
import 'package:app/firebase/firebase_auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/Screen/Login/components/background.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/already_have_an_account.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
import '../../../constraints.dart';
import '../../sign up/components/or_divider.dart';
import '../../sign up/components/signup_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();

  }

  void loginUser() {
    FirebaseAuthMethods(
      FirebaseAuth.instance
    ).loginWithEmail(
      email: _email.text, 
      password:_password.text, 
      context: context
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LOGIN",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              textEditingController: _email,
              hintText: "Your Email",
              onChanged: (
                value
              ) {},
            ),
            RoundedPasswordField(
              textEditingController: _password,
              onChanged: (
                value
              ) {}, 
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50, top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const ForgotPasswordPage()
                        )
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            RoundedButton(
              text: "LOGIN",
              press: loginUser,
              color: kPrimaryColor,
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: true,
              press: () {
                
                  Navigator.of(
                    context
                  ).push(
                    MaterialPageRoute(
                      builder: (context) => const signUpScreen()
                    )
                  );
                }       
            ),
            SizedBox(height: size.height * 0.03),
            const OrDivider(),
          ]
        ),
      ),
    );
  }
}