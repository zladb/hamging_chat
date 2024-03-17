import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../model/user.dart';
import '../../../provider/auth_provider.dart';

class MyPageScreen extends ConsumerStatefulWidget {
  const MyPageScreen({super.key});

  @override
  ConsumerState<MyPageScreen> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPageScreen> {
  late UserBase user;

  @override
  void initState() {
    super.initState();
    user = ref.read(authProvider);
  }

  @override
  Widget build(BuildContext context) {
    user = ref.watch(authProvider);
    if (user is UserLoading) {
      return const DefaultLayout(child: CircularProgressIndicator());
    } else {
      UserModel userInfo = user as UserModel;
      return DefaultLayout(
        title: 'MyPage',
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Profile(user: userInfo),
                const SizedBox(height: 16),
                _Contacts(user: userInfo),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.transparent),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return PRIMARY_COLOR;
                        }
                        return BODY_TEXT_COLOR;
                      },
                    ),
                  ),
                  child: const Text('로그아웃'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class _Profile extends StatelessWidget {
  final UserModel user;
  const _Profile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: IVORY,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              renderAvatar(),
              const SizedBox(width: 16),
              Expanded(
                // fit: BoxFit.fitWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    renderName(),
                    const SizedBox(height: 4),
                    const Text('ENTP 아가 개발자'),
                  ],
                ),
              ),
              renderEdit(user, context),
            ],
          ),
          const SizedBox(height: 16),
          renderComment(),
        ],
      ),
    );
  }

  Widget renderAvatar() {
    return CircleAvatar(
      backgroundColor: Colors.green,
      backgroundImage: NetworkImage(user.image),
      radius: 30,
    );
  }

  Widget renderName() {
    return Text(
      user.name,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget renderComment() {
    return Text(
      user.comment ?? '자기 소개를 등록해주세요!',
      maxLines: 8,
      textAlign: TextAlign.start,
    );
  }

  Widget renderEdit(UserModel user, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!context.mounted) return;
        context.go('/my_page/edit_profile', extra: user);
      },
      child: const Icon(Icons.mode),
    );
  }
}

class _Contacts extends StatelessWidget {
  final UserModel user;
  const _Contacts({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: IVORY,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.call),
                SizedBox(width: 16),
                Expanded(child: Text('+82 10 1234 5678')),
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
                Expanded(child: Text('secret@gmail.com')),
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
                Expanded(child: Text('+82 10 1234 5678')),
                SizedBox(width: 16),
                Text('Message'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
