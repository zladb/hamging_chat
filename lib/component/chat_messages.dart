import 'package:flutter/material.dart';
import 'package:flutter_block/model/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/chat_model.dart';
import '../provider/chat_provider.dart';
import 'message_bubble.dart';

class ChatMessages extends ConsumerStatefulWidget {
  ChatMessages({super.key, required this.receiverId});
  final String receiverId;

  @override
  ConsumerState<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends ConsumerState<ChatMessages> {
  // final messages = [
  //   Message(
  //     senderId: '1',
  //     receiverId: 'LAN2HQz0ZLWwVLqhklA5QkJKV472',
  //     content: 'hi',
  //     sentTime: DateTime.now(),
  //     messageType: MessageType.text,
  //   ),
  //   Message(
  //     senderId: 'LAN2HQz0ZLWwVLqhklA5QkJKV472',
  //     receiverId: '1',
  //     content: 'how are you?',
  //     sentTime: DateTime.now(),
  //     messageType: MessageType.text,
  //   ),
  //   Message(
  //     senderId: '1',
  //     receiverId: 'LAN2HQz0ZLWwVLqhklA5QkJKV472',
  //     content: 'fine',
  //     sentTime: DateTime.now(),
  //     messageType: MessageType.text,
  //   ),
  //   Message(
  //     senderId: '1',
  //     receiverId: 'LAN2HQz0ZLWwVLqhklA5QkJKV472',
  //     content:
  //         'https://story.agar.kr/files/attach/images/2021/08/04/fe57136ed0c63de54b3c91149c4ba566.jpg',
  //     sentTime: DateTime.now(),
  //     messageType: MessageType.image,
  //   ),
  // ];

  late ChatModel state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(chatProvider.notifier).getMessage(widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    print('build 실행');
    final state = ref.read(chatProvider) as ChatModel;
    // var
    // print(state.messages?.isEmpty);
    if (state.messages != null) {
      print('state의 상태는? ! -> ${state.messages?.length}');
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state!.messages!.length,
          itemBuilder: (BuildContext context, int index) {
            final isTextMessage =
                state!.messages![index].messageType == MessageType.text;
            final isMe = widget.receiverId != state!.messages![index].senderId;
            return isTextMessage
                ? MessageBubble(
                    isMe: isMe,
                    message: state!.messages![index],
                    isImage: false,
                  )
                : MessageBubble(
                    isMe: isMe,
                    message: state.messages![index],
                    isImage: true,
                  );
          },
        ),
      );
    } else {
      return Expanded(child: Container());
    }
  }
}
