import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String mobile;
  final String nic;

  const User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.mobile,
    required this.nic,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "email": email,
        "mobile": mobile,
        "nic": nic,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        uid: snapshot["uid"],
        firstName: snapshot["firstName"],
        lastName: snapshot["lastName"],
        username: snapshot["username"],
        email: snapshot["email"],
        mobile: snapshot["mobile"],
        nic: snapshot["nic"]);
  }
}
