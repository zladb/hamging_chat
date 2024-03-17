import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:flutter_block/screen/chat/chats_screen.dart';
import 'package:flutter_block/screen/search/search_screen.dart';

import '../../const/tabs.dart';
import '../user/mypage/my_page_screen.dart';

class NavigationScreen extends StatefulWidget {
  final Widget child;
  const NavigationScreen({
    required this.child,
    super.key,
  });

  @override
  State<NavigationScreen> createState() => _MainPageState();
}

class _MainPageState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: TABS.length, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  List pages = [
    const ChatsScreen(),
    const UserSearchScreen(),
    const MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[controller.index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: controller.index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          controller.animateTo(index);
        },
        items: TABS
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(
                  e.icon,
                ),
                label: e.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
