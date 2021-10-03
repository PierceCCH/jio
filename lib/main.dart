import 'package:flutter/material.dart';
import 'package:jio/screens/wrapper.dart';
import 'package:jio/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().userStream,
          ),
        ],
       child: MaterialApp(
        home: Wrapper()
      )
    );
  }
}
