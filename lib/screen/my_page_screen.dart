import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_block/screen/edit_user_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';
import '../provider/auth_provider.dart';

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
      var userInfo = user as UserModel;
      return DefaultLayout(
        title: 'MyPage',
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(color: IVORY),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            backgroundImage: NetworkImage(userInfo.image),
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
                                  userInfo.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text('ENTP 아가 개발자'),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (!context.mounted) return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditUserScreen(user: userInfo),
                                ),
                              );
                            },
                            child: const Icon(Icons.mode),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userInfo.comment ?? '자기 소개를 등록해주세요!',
                        maxLines: 8,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
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
                            Expanded(child: Text(userInfo.email)),
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
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    }
  }
}
