import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String key;
  String email;
  String name;
  String password;

  UserModel(this.email, this.name, this.password);

  UserModel.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
  email = snapshot.value["email"],
  name = snapshot.value["name"],
  password = snapshot.value["password"];

  toJson() {
    return {
      "email": email,
      "name": name,
      "password": password
    };
  }
}