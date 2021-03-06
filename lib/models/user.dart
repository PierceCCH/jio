class Person {
  final String uid;
  final String username;

  Person({this.uid, this.username});
}

class UserData {
  final String uid;
  final String name;
  final String email;
  final String password;

  UserData({this.uid, this.name, this.email, this.password});
}

class UserLocation {
  String latitude;
  String longitude;
}
