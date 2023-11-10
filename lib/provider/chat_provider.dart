import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/chat_model.dart';
import '../model/message.dart';
import '../model/user.dart';
import 'firebase_provider.dart';

final chatProvider = StateNotifierProvider<ChatNotifier, ChatBase>((ref) {
  final firebaseFirestore = ref.watch(firebaseFirestoreProvider);
  return ChatNotifier(firebaseFirestore: firebaseFirestore);
});

class ChatNotifier extends StateNotifier<ChatBase> {
  final FirebaseFirestore firebaseFirestore;
  ChatModel? chatModel;

  ChatNotifier({required this.firebaseFirestore}) : super(ChatLoading());

  Future<void> getUserById({required String userId}) async {
    UserModel _user;
    firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
          if (!user.exists){
            return;
          }else{
            // print(user.data());
            _user = UserModel.fromJson(user.data()!);
            state = ChatModel(user: _user);
          }
      // chatModel = state;
    });
    // return users;
  }

  Future<void> getMessage(
      {required String receiverId,
        required ScrollController scrollController}) async {
    List<Message> _messages;
    firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      _messages =
          messages.docs.map((doc) => Message.fromJson(doc.data())).toList();
      final cState = state as ChatModel;
      debugPrint(_messages.toString());
      scrollDown(scrollController);
      state = cState.copyWith(messages: _messages);
    });
    // return _messages;
  }

  void scrollDown(ScrollController scrollController) =>
      WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          }
        },
      );
}
