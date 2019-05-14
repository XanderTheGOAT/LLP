import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton(this.text, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blueGrey,
      child: Text(
        this.text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}
