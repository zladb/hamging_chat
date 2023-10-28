// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      lastActive:
          DataUtils.timeStampToDateTime(json['lastActive'] as Timestamp),
      isOnline: json['isOnline'] as bool? ?? false,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'lastActive': DataUtils.dateTimeToTimeStamp(instance.lastActive),
      'isOnline': instance.isOnline,
    };
