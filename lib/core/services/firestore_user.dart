import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user_model.dart';

class FireStoreUser{
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('Users');

  addUserToFirestore(UserModel userModel) async {
    await _usersCollection.doc(userModel.userId).set(userModel.toJson());
  }

  Future<DocumentSnapshot> getUserFromFirestore(String uid) async {
    return await _usersCollection.doc(uid).get();
  }
}