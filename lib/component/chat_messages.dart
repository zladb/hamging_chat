import 'package:flutter/material.dart';
import 'package:flutter_block/model/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/chat_model.dart';
import '../provider/chat_provider.dart';
import 'message_bubble.dart';

class ChatMessages extends ConsumerStatefulWidget {
  final String receiverId;
  final ScrollController scrollController;

  const ChatMessages({
    super.key,
    required this.receiverId,
    required this.scrollController,
  });

  @override
  ConsumerState<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends ConsumerState<ChatMessages> {
  @override
  void initState() {
    super.initState();
    ref.read(chatProvider.notifier).getMessage(
          receiverId: widget.receiverId,
          scrollController: widget.scrollController,
        );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.read(chatProvider) as ChatModel;
    if (state.messages != null) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              controller: widget.scrollController,
              shrinkWrap: true,
              itemCount: state.messages!.length,
              itemBuilder: (BuildContext context, int index) {
                final isTextMessage =
                    state.messages![index].messageType == MessageType.text;
                final isMe =
                    widget.receiverId != state.messages![index].senderId;
                return isTextMessage
                    ? MessageBubble(
                        isMe: isMe,
                        message: state.messages![index],
                        isImage: false,
                      )
                    : MessageBubble(
                        isMe: isMe,
                        message: state.messages![index],
                        isImage: true,
                      );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 8);
              },
            ),
          ),
        ),
      );
    } else {
      return Expanded(child: Container());
    }
  }
}
