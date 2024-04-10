
import 'package:flutter/material.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return background(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              "ABOUT", 
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            Image.asset("assets/images/about.png"),
            const Text("This App was made specifically for the purpose of\n\"Major Project\" (18ECP68).\n\nThis Application provides a live analysis of traffic which\nis generated through hardware parts. This App in no\nway provides any \"Real world\" data."),
            const Text("\nApp made for the project idea :                                            ")
          ],
        ),
      ),
    );
  }
}