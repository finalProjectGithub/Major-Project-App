import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final VoidCallback press;

  const RoundedButton({
    super.key, 
    required this.text, 
    required this.color, 
    this.textColor = Colors.white, 
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(29)
            ),
          ),
          padding: WidgetStateProperty.all<
            EdgeInsets
          >(
            const EdgeInsets.symmetric(
              vertical: 20, 
              horizontal: 40
            )
          )
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}

