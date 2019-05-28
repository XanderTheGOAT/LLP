import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double fontSize;
  const CustomButton(this.text,
      {this.onPressed, this.width = 85, this.height = 35, this.fontSize = 15});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: width,
      height: height,
      child: RaisedButton(
        color: Colors.blueGrey,
        child: Text(
          this.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
