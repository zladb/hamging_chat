import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/user_item.dart';
import '../model/user.dart';
import '../provider/firebase_provider.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  //
  // List<User> user_list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(fireStoreProvider.notifier).getAllUsers();
    // });
  }


  List<UserModel>? chat_list;

  @override
  Widget build(BuildContext context) {
    // ref.read(fireStoreProvider.notifier).putDummyData();
    // ref.read(fireStoreProvider.notifier).getAllUser();
    // final chat_list = ref.read(fireStoreProvider.notifier).getAllUsers();

    // state = ref.watch(fireStoreProvider);
    // ref.watch(fireStoreProvider.notifier).getAllUsers().then((value) => chat_list = value);
    chat_list = ref.watch(fireStoreProvider);
    print('chats screen 내부에서 -> $chat_list');

    if (chat_list!.length == 0){
      return Container(child: Center(child: CircularProgressIndicator(),),);
    }
    else
    return DefaultLayout(
      title: 'Chats',
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: chat_list!.length,
        itemBuilder: (context, index) => UserItem(user: chat_list![index]),
      ),
    );
  }

  Future<List<UserModel>> get_user(Ref ref) async {
    final chat_list = await ref.read(fireStoreProvider);
    return chat_list;
  }
}

void putDummyData() {
  var firebaseFirestore = FirebaseFirestore.instance;
  final users = firebaseFirestore.collection("users");

  final cities = firebaseFirestore.collection("cities");
  final data1 = <String, dynamic>{
    "name": "San Francisco",
    "state": "CA",
    "country": "USA",
    "capital": false,
    "population": 860000,
    "regions": ["west_coast", "norcal"]
  };
  cities.doc("SF").set(data1);

  users.doc('0').set(UserModel(
    uid: '0',
    name: 'Hazy',
    email: 'test@test.test',
    image: 'https://i.pravatar.cc/150?img=0',
    isOnline: true,
    lastActive: DateTime.now(),
  ).toJson());

  // 더미 유저 데이터
  final userData = [
    UserModel(
      uid: '0',
      name: 'Hazy',
      email: 'test@test.test',
      image: 'https://i.pravatar.cc/150?img=0',
      isOnline: true,
      lastActive: DateTime.now(),
    ),
    UserModel(
      uid: '1',
      name: 'Charlotte',
      email: 'test@test.test',
      image: 'https://i.pravatar.cc/150?img=1',
      isOnline: false,
      lastActive: DateTime.now(),
    ),
    UserModel(
      uid: '2',
      name: 'Ahmed',
      email: 'test2@test.test',
      image: 'https://i.pravatar.cc/150?img=2',
      isOnline: true,
      lastActive: DateTime.now(),
    ),
    UserModel(
      uid: '3',
      name: 'Yujin',
      email: 'test3@test.test',
      image: 'https://i.pravatar.cc/150?img=3',
      isOnline: false,
      lastActive: DateTime.now(),
    ),
  ];

  for (int i=0; i<userData.length; i++) {
    print('하이');
    users.doc(userData[i].uid).set(userData[i].toJson());
  }

  userData.map((user) {
    print('map 실행');
    return users.doc(user.uid).set(user.toJson());
  });
}
