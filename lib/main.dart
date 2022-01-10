import 'package:flutter/material.dart';
import 'package:jio/screens/wrapper.dart';
import 'package:jio/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider<Person>.value(
        value: AuthService().userStream,
      ),
    ], child: MaterialApp(home: Wrapper()));
  }
}
