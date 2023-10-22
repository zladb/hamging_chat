
import 'package:flutter_block/model/user.dart';

import 'message.dart';

abstract class ChatBase{}

class ChatLoading extends ChatBase{

}

class ChatError extends ChatBase{

}

class ChatModel extends ChatBase{
  final UserModel user;
  final List<Message>? messages;

  ChatModel({required this.user, this.messages});


  ChatModel copyWith({
    UserModel? user,
    List<Message>? messages,
  }){
    return ChatModel(
      user: user ?? this.user,
      messages: messages ?? this.messages,
    );
  }
}