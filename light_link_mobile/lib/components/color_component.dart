import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorComponent extends StatelessWidget {
  final String color;
  final String name;
  ColorComponent(this.color, this.name);
  @override
  Widget build(BuildContext context) {
    return Row(
      verticalDirection: VerticalDirection.up,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30),
          child: Text(this.name),
        ),
        this.buildColor(),
      ],
    );
  }

  Widget buildColor() {
    var color = Color(int.parse(this.color, radix: 16));
    var widget = Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
        color: color,
      ),
    );
    return widget;
  }
}
