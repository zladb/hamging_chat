import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../model/user.dart';
import '../screen/chat_screen.dart';
import '../screen/user_page_screen.dart';

class UserItem extends StatefulWidget {
  final UserModel user;
  final bool isSearch;
  const UserItem({
    super.key,
    required this.user,
    required this.isSearch,
  });

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  // final String? heroKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => widget.isSearch
              ? UserPage(
            user: widget.user,
          )
              : ChatScreen(
            userId: widget.user.uid,
            user: widget.user,
          ),
        ),
      ),
      child: ListTile(
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              backgroundImage: NetworkImage(widget.user.image),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: CircleAvatar(
                backgroundColor:
                widget.user.isOnline ? Colors.green : Colors.grey,
                radius: 5,
              ),
            )
          ],
        ),
        title: Text(
          widget.user.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Last Active : ${timeago.format(widget.user.lastActive)}',
          // 'Last Active: ${widget.user.lastActive.toIso8601String()}',
          maxLines: 2,
          style: const TextStyle(
            color: BODY_TEXT_COLOR,
            fontSize: 15,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
