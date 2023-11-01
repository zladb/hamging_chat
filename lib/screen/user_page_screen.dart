import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';
import '../provider/auth_provider.dart';
import 'chat_screen.dart';

class UserPage extends ConsumerStatefulWidget {
  late UserModel? user;
  UserPage({super.key, this.user});

  @override
  ConsumerState<UserPage> createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<UserPage> {
  bool isMe = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.user == null){
      isMe = true;
      widget.user ??= ref.read(authProvider) as UserModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      return DefaultLayout(child: CircularProgressIndicator());
    } else {
      return DefaultLayout(
        title: 'User page',
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(color: IVORY),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            backgroundImage: NetworkImage(widget.user!.image),
                            radius: 30,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.user!.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text('ENTP 아가 개발자'),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        '안녕! 나는 김유진이야. 헤헤 배고프당 내가 좋아하는 음식은 소고기, 돼지고기, 닭고기 등등등 아주 다양하단다. 아오아오앙 아오아 마이페이지 만들기 귀찮다 ~ 색은 뭘로 해야 좋을까 ~ 내 이름 수정하는 부분도 만드렁야 하는데 ~',
                        maxLines: 8,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(color: IVORY),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
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
                            Icon(Icons.mail),
                            SizedBox(width: 16),
                            Expanded(child: Text(widget.user!.email)),
                            SizedBox(width: 16),
                            Text('Email'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
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
                SizedBox(
                  height: 16,
                ),
                if(!isMe)
                ElevatedButton(
                  onPressed: () async {
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          userId: widget.user!.uid,
                          user: widget!.user as UserModel,
                        ),
                      ),
                    );
                  },
                  child: Text('채팅 하기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    padding: const EdgeInsets.all(20),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
