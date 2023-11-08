import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/data_utils.dart';

part 'user.g.dart';

abstract class UserBase {}

class UserNone extends UserBase {}

class UserLoading extends UserBase {}

class UserCreating extends UserBase {}

class UserError extends UserBase {}

class UserModelList extends UserBase {
  final List<UserModel> userList;

  UserModelList({
    required this.userList,
  });
}

@JsonSerializable()
class UserModel extends UserBase {
  final String uid;
  final String name;
  final String email;
  final String image;
  @JsonKey(
      fromJson: DataUtils.timeStampToDateTime,
      toJson: DataUtils.dateTimeToTimeStamp)
  final DateTime lastActive;
  final bool isOnline;
  final String? comment;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.lastActive,
    this.isOnline = false,
    this.comment,
  });

  // // TODO(zladb): JsonSerializable하게 구현해보기
  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     uid: json['uid'],
  //     name: json['name'],
  //     email: json['email'],
  //     image: json['image'],
  //     isOnline: json['isOnline'] ?? false,
  //     lastActive: (json['lastActive'] as Timestamp).toDate(),
  //   );
  // }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Json으로 변환
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? image,
    DateTime? lastActive,
    bool? isOnline,
    String? comment,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      lastActive: lastActive ?? this.lastActive,
      isOnline: isOnline ?? this.isOnline,
      comment: comment ?? this.comment,
    );
  }
}
