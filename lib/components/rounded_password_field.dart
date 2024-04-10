import 'package:flutter/material.dart';
import '../constraints.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  const RoundedPasswordField({
    super.key, 
    required this.onChanged, 
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Password",
          border: InputBorder.none,
          icon: Icon(
            Icons.lock, 
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility, 
            color: kPrimaryColor
          ),
        ),
      ),
    );
  }
}