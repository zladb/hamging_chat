
// 더미 유저 데이터
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/user.dart';

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



  for (int i=0; i<userData.length; i++) {
    debugPrint('하이');
    users.doc(userData[i].uid).set(userData[i].toJson());
  }

  userData.map((user) {
    debugPrint('map 실행');
    return users.doc(user.uid).set(user.toJson());
  });
}
