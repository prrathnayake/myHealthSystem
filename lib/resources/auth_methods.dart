import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_health/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  Future<String> userSignUp({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String nic,
    required String mobile,
    required String password,
    required String comfirmPassword,
  }) async {
    String res = "Some Error Occurred";
    try {
      RegExp regexNIC = RegExp(r'^(?:19|20)?\d{2}[0-9]{10}|[0-9]{9}[x|X|v|V]$');
      RegExp regexMobile = RegExp(r'^[0]{1}[7]{1}[01245678]{1}[0-9]{7}$');

      if (!regexNIC.hasMatch(nic)) {
        return res = "Pleace enter valid NIC number";
      }

      if (!regexMobile.hasMatch(mobile)) {
        return res = "Pleace enter valid mobile number";
      }

      if (password != comfirmPassword) {
        return res = "Pleace make sure your passwords match";
      }

      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          mobile.isNotEmpty ||
          firstName.isNotEmpty ||
          lastName.isNotEmpty ||
          nic.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        model.User user = model.User(
          uid: userCredential.user!.uid,
          nic: nic,
          firstName: firstName,
          lastName: lastName,
          email: email,
          username: username,
          mobile: mobile,
        );

        await _firestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(user.toJson());

        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> userSignIn({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> changeData({
    required String uid,
    required String firstName,
    required String lastName,
    required String username,
    required String nic,
    required String mobile,
  }) async {
    String res = "Some Error Occurred";
    try {
      RegExp regexNIC = RegExp(r'^(?:19|20)?\d{2}[0-9]{10}|[0-9]{9}[x|X|v|V]$');
      RegExp regexMobile = RegExp(r'^[0]{1}[7]{1}[01245678]{1}[0-9]{7}$');

      if (!regexNIC.hasMatch(nic)) {
        return res = "Pleace enter valid NIC number";
      }

      if (!regexMobile.hasMatch(mobile)) {
        return res = "Pleace enter valid mobile number";
      }

      _firestore.collection('users').doc(uid).update({
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "nic": nic,
        "mobile": mobile
      });
      res = "success";
    } catch (err) {
      return err.toString();
    }

    return res;
  }

  Future<String> changePassword(password) async {
    try {
      User currentUser = _auth.currentUser!;
      await currentUser.updatePassword(password);
      return "success";
    } catch (err) {
      return err.toString();
    }
  }
}
