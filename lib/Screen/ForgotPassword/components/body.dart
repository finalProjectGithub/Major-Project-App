import 'package:app/Screen/ForgotPassword/components/background.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/components/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/showSnackBar.dart';
import '../../../constraints.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text.trim());
      showSnackBar(context, "Reset Link sent to your Email!");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return background(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.2,),
              const Text(
                "RESET PASSWORD",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: size.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: const Text("Enter your Email")
                   )
                ],
              ),
              RoundedInputField(
                hintText: "Email", 
                onChanged: (value) => {},
                textEditingController: _email
              ),
              RoundedButton(
                text: "RESET PASSWORD", 
                color: kPrimaryColor, 
                press: passwordReset
              )
            ],
          ),
        ),
      ),
    );
  }
}
