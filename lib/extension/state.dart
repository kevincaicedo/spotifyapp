import 'package:flutter/material.dart';

extension Alerts on State {
  void showSnackBar(content, {Duration duration = const Duration(seconds: 2)}) {
    final snackBar = SnackBar(
      content: content,
      duration: duration,
      backgroundColor: Colors.white,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget buildCircularLoading() {
    return Row(
      children: <Widget>[
        CircularProgressIndicator(
          backgroundColor: Colors.black,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Loading...",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
        )
      ],
    );
  }

  Widget buildMessageError(message) {
    return Text(
      message,
      style: TextStyle(
          color: Colors.red, fontWeight: FontWeight.w800, fontSize: 20),
    );
  }
}
