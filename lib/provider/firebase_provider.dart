import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/message.dart';
import '../model/user.dart';

final firebaseFiresotreProvider = Provider((ref) => FirebaseFirestore.instance);

final fireStoreProvider =
    StateNotifierProvider<FireStoreNotifier, UserBase>((ref) {
  final firebaseFirestore = ref.watch(firebaseFiresotreProvider);
  return FireStoreNotifier(firebaseFirestore: firebaseFirestore);
});

class FireStoreNotifier extends StateNotifier<UserBase> {
  final FirebaseFirestore firebaseFirestore;
  final myUid = FirebaseAuth.instance.currentUser!.uid;
  List<UserModel> users = [];

  FireStoreNotifier({required this.firebaseFirestore}) : super(UserLoading()) {
    getUserChattedBefore();
  }
  // Future<List<UserModel>> getAllUsers() async {
  //   print('getAllUsers 실행');
  //   await firebaseFirestore
  //       .collection('users')
  //       .snapshots(includeMetadataChanges: true)
  //       .listen((users) {
  //     this.users =
  //         users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  //     this.users.removeWhere((item) => item.uid == myUid);
  //     state = this.users;
  //   });
  //   // print(this.users)
  //   print('get all users 잘 작동하나 ? -> ${this.users}');
  //   return this.users;
  // }

  Future<List<UserModel>> getUserChattedBefore() async {
    List<UserModel> temp = [];
    print('getUserChattedBefore 실행');
    await firebaseFirestore
        .collection('users')
        .doc(myUid)
        .collection("chat")
        .snapshots(includeMetadataChanges: true)
        .listen(
      (users) {
        print("Successfully completed");
        print('myUid ${myUid}');
        print(users.size);
        temp = users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();

        state = UserModelList(userList: temp);
      },
      onError: (e) {
        state = UserError();
        print("Error completing: $e");
      },
    );
    return temp;
  }

  // void getAllUser() {
  //   final UserModel user;
  //   firebaseFirestore.collection("users").get().then(
  //     (querySnapshot) {
  //       print("Successfully completed");
  //       for (var docSnapshot in querySnapshot.docs) {
  //         print('${docSnapshot.id} => ${docSnapshot.data()}');
  //       }
  //     },
  //     onError: (e) => print("Error completing: $e"),
  //   );
  // }

  // void putDummyData() {
  //   print('put dummy data 함수 실행 ');
  //   final users = firebaseFirestore.collection("users");
  //   final currentTime = DateTime.now();
  //   Timestamp myTimeStamp = Timestamp.fromDate(currentTime);
  //   print(myTimeStamp);
  //
  //   // 더미 유저 데이터
  //   final userData = [
  //     UserModel(
  //       uid: '0',
  //       name: 'Hazy',
  //       email: 'test@test.test',
  //       image: 'https://i.pravatar.cc/150?img=0',
  //       isOnline: true,
  //       lastActive: myTimeStamp,
  //     ),
  //     UserModel(
  //       uid: '1',
  //       name: 'Charlotte',
  //       email: 'test@test.test',
  //       image: 'https://i.pravatar.cc/150?img=1',
  //       isOnline: false,
  //       lastActive: myTimeStamp,
  //     ),
  //     UserModel(
  //       uid: '2',
  //       name: 'Ahmed',
  //       email: 'test2@test.test',
  //       image: 'https://i.pravatar.cc/150?img=2',
  //       isOnline: true,
  //       lastActive: myTimeStamp,
  //     ),
  //     UserModel(
  //       uid: '3',
  //       name: 'Yujin',
  //       email: 'test3@test.test',
  //       image: 'https://i.pravatar.cc/150?img=3',
  //       isOnline: false,
  //       lastActive: myTimeStamp,
  //     ),
  //   ].forEach((user) async {
  //     print('${user.uid} - ${user.name.padRight(10)} \t 데이터 fireStore 저장');
  //     return await users.doc(user.uid.toString()).set(user.toJson());
  //   });
  //   print('put dummy data 완료 ');
  // }
}
