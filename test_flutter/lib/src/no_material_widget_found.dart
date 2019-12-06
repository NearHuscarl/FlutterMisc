import 'package:flutter/material.dart';

/// https://stackoverflow.com/questions/53855681/another-exception-was-thrown-no-material-widget-found
class NoMaterialWidgetFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextFormField(initialValue: 'abc'),
    );
  }
}
