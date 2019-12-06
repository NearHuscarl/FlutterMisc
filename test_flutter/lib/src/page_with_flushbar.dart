import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class PageWithFlushbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: MaterialButton(
            child: Text('Press Me'),
            onPressed: () {
              Flushbar(
                title: "Hey Ninja",
                message:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                backgroundGradient: LinearGradient(
                  colors: [Colors.blue, Colors.teal],
                ),
                backgroundColor: Colors.red,
                boxShadows: [
                  BoxShadow(
                    color: Colors.blue[800],
                    offset: Offset(0.0, 2.0),
                    blurRadius: 3.0,
                  )
                ],
              )..show(context);
            },
          ),
        ),
      ),
    );
  }
}
