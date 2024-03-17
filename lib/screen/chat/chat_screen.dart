import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_block/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../component/chat_messages.dart';
import '../../component/chat_text_field.dart';
import '../../model/chat_model.dart';
import '../../provider/chat_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final UserModel user;

  const ChatScreen({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(chatProvider.notifier).getUserById(userId: widget.user.uid);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatProvider);

    if (state is ChatLoading) {
      ref.read(chatProvider.notifier).getUserById(userId: widget.user.uid);
      return const Scaffold(body: CircularProgressIndicator());
    }
    if (state is ChatError) {
      return Container();
    } else {
      return Scaffold(
        appBar: _buildAppBar(state as ChatModel),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ChatMessages(
                receiverId: widget.user.uid,
                scrollController: scrollController,
              ),
              ChatTextField(
                receiver: state.user,
                receiverId: widget.user.uid,
                scrollController: scrollController,
              ),
            ],
          ),
        ),
      );
    }
    // return Container();
  }

  AppBar _buildAppBar(ChatModel state) {
    return AppBar(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.user.image),
            radius: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 3,
                    backgroundColor:
                        widget.user.isOnline ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.user.isOnline ? 'Online' : 'Offline',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<UserModel?> getUserById({required String userId}) async {
  final firebaseFirestore = FirebaseFirestore.instance;
  UserModel? gotUser;
  firebaseFirestore
      .collection('users')
      .doc(userId)
      .snapshots(includeMetadataChanges: true)
      .listen((user) {
    gotUser = UserModel.fromJson(user.data()!);
  });
  return gotUser;
}
