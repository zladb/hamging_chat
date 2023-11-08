import 'package:flutter/material.dart';
import 'package:flutter_block/component/custom_text_from_field.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_block/provider/search_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../component/user_item.dart';
import '../model/user.dart';

class UserSearchScreen extends ConsumerStatefulWidget {
  const UserSearchScreen({super.key});

  @override
  ConsumerState<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends ConsumerState<UserSearchScreen> {
  final controller = TextEditingController();
  String? userName;
  List<UserModel>? userData;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userData = ref.watch(userSearchProvider);
    if (userData == []) {
      return const CircularProgressIndicator();
    } else {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: DefaultLayout(
          title: 'User Search',
          child: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: CustomTextFormField(
                  isChat: true,
                  controller: controller,
                  isSearch: true,
                  onChanged: (String value) {
                    ref
                        .read(userSearchProvider.notifier)
                        .searchUser(name: value);
                    // userName = value;
                  },
                  hintText: 'Search',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  // shrinkWrap: true,
                  // padding: const EdgeInsets.all(16),
                  itemCount: userData!.length,
                  itemBuilder: (context, index) {
                    return UserItem(
                      user: userData![index],
                      isSearch: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
