import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../const/colors.dart';
import '../const/tabs.dart';

class Navigation extends StatelessWidget {
  final Widget child;
  const Navigation({
    super.key,
    required this.child,
  });

  int getIndex(BuildContext context) {
    if (GoRouterState.of(context).uri.toString() == '/chats' ||
        GoRouterState.of(context).uri.toString() == '/chats/chat') {
      return 0;
    } else if (GoRouterState.of(context).uri.toString() == '/search') {
      return 1;
    } else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: getIndex(context),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            context.go('/chats');
          } else if (index == 1) {
            context.go('/search');
          } else {
            context.go('/my_page');
          }
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
