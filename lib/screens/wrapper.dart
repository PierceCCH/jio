import "package:flutter/material.dart";
import 'package:jio/models/user.dart';
import 'package:jio/screens/authenticate/authenticate.dart';
import 'package:jio/screens/home/home.dart';
import 'package:jio/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //accessing user data from provider
    final user = Provider.of<User>(context);

    if (user == null){
      return Authenticate();
    }
    else{
      return StreamProvider.value(
        value: DatabaseService(uid: user.uid).userData,
        child: Home());
    }
  }
}