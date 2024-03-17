import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../component/user_item.dart';
import '../../model/user.dart';
import '../../provider/firebase_provider.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  late UserBase state;

  @override
  void initState() {
    super.initState();
    ref.read(fireStoreProvider.notifier).getUserChattedBefore();
    state = ref.read(fireStoreProvider);
  }

  @override
  Widget build(BuildContext context) {
    state = ref.watch(fireStoreProvider);

    if (state is UserLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is UserError) {
      ref.read(fireStoreProvider.notifier).getUserChattedBefore();
      return const Center(
        child: Text('에러입니다.'),
      );
    } else {
      var users = state as UserModelList;
      if (users.userList.isEmpty) {
        return const DefaultLayout(
          title: 'Chats',
          child: Center(
            child: Text(
              '아직 이야기를 나눈 사람이 없어요.\n대화를 시작해보세요!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: GREY,
              ),
            ),
          ),
        );
      } else {
        return DefaultLayout(
          title: 'Chats',
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: users.userList.length,
            itemBuilder: (context, index) => UserItem(
              user: users.userList[index],
              isSearch: false,
            ),
          ),
        );
      }
    }
  }
}
