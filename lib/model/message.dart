
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/data_utils.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String senderId;
  final String receiverId;
  final String content;
  @JsonKey(fromJson: DataUtils.timeStampToDateTime)
  final DateTime sentTime;
  final MessageType messageType;

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.sentTime,
    required this.messageType,
  });

  factory Message.fromJson(Map<String,dynamic> json)
  => _$MessageFromJson(json);
  
  Map<String, dynamic> toJson() => {
    'receiverId': receiverId,
    'senderId': senderId,
    'sentTime': sentTime,
    'content':  content,
    'messageType': messageType.toJson(),
  };
}

enum MessageType {
  text,
  image;

  String toJson() => name;
}
