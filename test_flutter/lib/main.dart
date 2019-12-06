import 'package:flutter/material.dart';
import 'package:test_flutter/src/sqflite_attempt_to_write_in_readonly_database.dart';
import 'src/no_material_widget_found.dart';
import 'src/home_page.dart';
import 'src/login_page.dart';
import 'src/page_with_animated_list.dart';

void main() => runApp(MyApp());

const primaryColor = Colors.deepOrange;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        accentColor: Colors.amber,
      ),
      title: 'YourAwesomeApp',
      home: SqfliteAttemptToWriteInReadonlyDatabase(),
    );

    // FlutterLogin test
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(primarySwatch: Colors.blue),
    //   home: LoginPage(),
    // );
  }
}
