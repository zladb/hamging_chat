import 'package:flutter/material.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/user_item.dart';
import '../model/user.dart';
import '../provider/firebase_provider.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {

  // late List<UserModel> chat_list;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // ref.read(fireStoreProvider.notifier).getAllUsers();
    // chat_list = ref.read(fireStoreProvider.notifier).getUserChattedBefore();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(fireStoreProvider.notifier).getAllUsers();
    // });
  }


  @override
  Widget build(BuildContext context) {
    // ref.read(fireStoreProvider.notifier).putDummyData();
    // ref.read(fireStoreProvider.notifier).getAllUser();
    // final chat_list = ref.read(fireStoreProvider.notifier).getAllUsers();

    // state = ref.watch(fireStoreProvider);
    // ref.watch(fireStoreProvider.notifier).getAllUsers().then((value) => chat_list = value);
    var state = ref.watch(fireStoreProvider);

    if (state is UserLoading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else if (state is UserError){
      ref.read(fireStoreProvider.notifier).getUserChattedBefore();
      return Container(
        child: Center(
          child: Text('ㄷㄷ 에러같은디요'),
        ),
      );
    }
    else {
      print(state);
      var users = state as UserModelList;
      return DefaultLayout(
        title: 'Chats',
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: users.userList!.length,
          itemBuilder: (context, index) => UserItem(user: users.userList![index]),
        ),
      );
    }
  }

  // Future<List<UserModel>> get_user(Ref ref) async {
  //   chat_list = ref.read(fireStoreProvider.notifier).getUserChattedBefore();
  //   // return chat_list;
  // }
}
