import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';

import '../model/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool isImage;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.isImage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            color: isMe ? IVORY : PRIMARY_COLOR,
            borderRadius: isMe
                ? BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
        margin: EdgeInsets.only(right: 10, left: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            isImage
                ? Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: NetworkImage(message.content),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Text(
                    message.content,
                    style: TextStyle(color: isMe? Colors.black : Colors.white),
                  ),
          ],
        ),
      ),
    );
  }
}
