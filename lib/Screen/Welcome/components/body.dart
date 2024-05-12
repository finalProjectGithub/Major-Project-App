import 'package:app/Screen/sign%20up/components/or_divider.dart';
import 'package:app/firebase/fetch_vechicle_count.dart';
import 'package:flutter/material.dart';

import '../../../components/rounded_button.dart';
import '../../../constraints.dart';
import '../../About/about_screen.dart';
import '../../DataPage/data_page.dart';
import '../../Login/login_screen.dart';
import '../../sign up/components/signup_screen.dart';
import 'background.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return Background(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: 300,
                height: 231,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.asset("assets/GIFs/car.gif"),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              RoundedButton(
                text: "Login",
                color: kPrimaryColor,
                press : () {
                  Navigator.of(
                    context
                  ).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen()
                    )
                  );
                }
              ),
              RoundedButton(
                text: "Sign Up",
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => signUpScreen()));
                }
              ),
              SizedBox(height: size.height * 0.05,),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutScreen()));
                    }, 
                    child: Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                                  child: Icon(Icons.info, color: kPrimaryColor,size: 30,),                                  
                                )
                              )
                            ]
                          )
                        )
                      ],
                    ) 
                  )
                ],
              ),
              OrDivider(),
            ],
          ),
        ],
      ),
    );
  }
}




