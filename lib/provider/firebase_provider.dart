import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_block/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';

final firebaseFirestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final fireStoreProvider =
    StateNotifierProvider<FireStoreNotifier, UserBase>((ref) {
  final firebaseFirestore = ref.watch(firebaseFirestoreProvider);
  final me = ref.watch(authProvider) as UserModel;
  return FireStoreNotifier(
      firebaseFirestore: firebaseFirestore, me: me);
});

class FireStoreNotifier extends StateNotifier<UserBase> {
  final FirebaseFirestore firebaseFirestore;
  UserModel me;
  List<UserModel> users = [];

  FireStoreNotifier({
    required this.firebaseFirestore,
    required this.me,
  }) : super(UserLoading());

  Future<List<UserModel>> getUserChattedBefore() async {
    String myUid = me.uid;
    // debugPrint('지금 uid 는? $myUid');
    List<UserModel> temp = [];
    debugPrint('getUserChattedBefore 실행');
    firebaseFirestore
        .collection('users')
        .doc(myUid)
        .collection("chat")
        .snapshots()
        .listen(
      (users) {
        // debugPrint("listen 함수 실행");
        // debugPrint('firebaseProvider myUid ${myUid}');
        // debugPrint(users.size.toString());
        temp = users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();

        if(mounted) {
          state = UserModelList(userList: temp);
        }
      },
      onError: (e) {
        state = UserError();
        debugPrint("Error completing: $e");
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
