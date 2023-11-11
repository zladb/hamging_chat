import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';
import 'firebase_provider.dart';

final userSearchProvider =
StateNotifierProvider<UserSearchNotifier, List<UserModel>>((ref) {
  final firebaseFirestore = ref.watch(firebaseFirestoreProvider);
  return UserSearchNotifier(firebaseFirestore: firebaseFirestore);
});

class UserSearchNotifier extends StateNotifier<List<UserModel>> {
  final FirebaseFirestore firebaseFirestore;
  List<UserModel> users = [];

  UserSearchNotifier({required this.firebaseFirestore}) : super([]) {
    getAllUsers();
  }
  Future<List<UserModel>> getAllUsers() async {
    debugPrint('getAllUsers 실행');
    firebaseFirestore
        .collection('users')
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users =
          users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      this.users.removeWhere(
              (item) => item.uid == FirebaseAuth.instance.currentUser!.uid);
      state = this.users;
    });
    return users;
  }

  Future<List<UserModel>> searchUser({required String name}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("name", isGreaterThanOrEqualTo: name.toUpperCase())
        .get();

    var searchResult =
    snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
    state = searchResult;
    return state;
  }
}
