import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../model/user.dart';

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
      onTap: () => widget.isSearch ?
      context.go('/search/user', extra: widget.user) :
      context.go('/chats/chat', extra: widget.user), // push로 바꿀 수도 있음.

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
