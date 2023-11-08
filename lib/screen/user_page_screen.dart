import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';
import 'chat_screen.dart';

class UserPage extends ConsumerStatefulWidget {
  final UserModel user;
  const UserPage({super.key, required this.user});

  @override
  ConsumerState<UserPage> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<UserPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'User page',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              userInfo(),
              const SizedBox(height: 16),
              contactInfoList(),
              const SizedBox(height: 16),
              startChatButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget userInfo() {
    return Container(
      decoration: const BoxDecoration(color: IVORY),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                backgroundImage: NetworkImage(widget.user.image),
                radius: 30,
              ),
              const SizedBox(width: 16),
              Expanded(
                // fit: BoxFit.fitWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    const Text('ENTP 아가 개발자'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.user.comment ?? '등록된 자기 소개가 없습니다',
            maxLines: 8,
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }

  Widget contactInfoList() {
    return Container(
      decoration: const BoxDecoration(color: IVORY),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.call),
                SizedBox(width: 16),
                Expanded(child: Text('+82 10 5525 1050')),
                SizedBox(width: 16),
                Text('Mobile'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.mail),
                const SizedBox(width: 16),
                Expanded(child: Text(widget.user.email)),
                const SizedBox(width: 16),
                const Text('Email'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.message),
                SizedBox(width: 16),
                Expanded(child: Text('+82 10 5525 1050')),
                SizedBox(width: 16),
                Text('Message'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget startChatButton() {
    return ElevatedButton(
      onPressed: () async {
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              userId: widget.user.uid,
              user: widget.user,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: PRIMARY_COLOR,
        padding: const EdgeInsets.all(20),
      ),
      child: const Text('채팅 하기'),
    );
  }
}
