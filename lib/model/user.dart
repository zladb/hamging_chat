import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/data_utils.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  // @JsonKey(fromJson: DataUtils.timeStampToDateTime)
  final DateTime lastActive;
  final bool isOnline;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.lastActive,
    this.isOnline = false,
  });

  // TODO(zladb): JsonSerializable하게 구현해보기
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      isOnline: json['isOnline'] ?? false,
      lastActive: (json['lastActive'] as Timestamp).toDate(),
    );
  }

  // factory UserModel.fromJson(Map<String,dynamic> json)
  // => _$UserModelFromJson(json);
  
  // Json으로 변환
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
