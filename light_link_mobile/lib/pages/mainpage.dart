import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
            ),
            child: Text(
              'Light Link',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'serif',
                color: Colors.amber,
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[],
          ),
        ));
  }
}
