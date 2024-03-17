import 'package:flutter_block/screen/user/login/login_screen.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../model/user.dart';
import '../screen/user/register/authentication_notice_screen.dart';
import '../screen/chat/chat_screen.dart';
import '../screen/chat/chats_screen.dart';
import '../screen/user/mypage/edit_user_screen.dart';
import '../screen/user/mypage/my_page_screen.dart';
import '../screen/navigation/navigation.dart';
import '../screen/user/register/register_screen.dart';
import '../screen/search/search_screen.dart';
import '../screen/user/mypage/user_page_screen.dart';

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
      // TODO: ShellRoute 해서 여기다가 네비게이터 스크린 넣으면 될 듯
      routes: [
        GoRoute(
          path: 'login',
          name: 'login',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LoginScreen()),
        ),
        GoRoute(
          path: 'register',
          name: 'register',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: RegisterScreen()),
          routes: [
            GoRoute(
              path: 'notice',
              name: 'notice',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AuthenticationNoticeScreen()),
            ),
          ],
        ),
        ShellRoute(
          builder: (context, state, child) {
            return Navigation(child: child);
          },
          routes: [
            GoRoute(
              path: 'chats',
              name: 'chats',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ChatsScreen()),
              routes: [
                GoRoute(
                  path: 'chat',
                  name: 'chat',
                  pageBuilder: (context, state) {
                    UserModel user = state.extra as UserModel;
                    return NoTransitionPage(child: ChatScreen(user: user));
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'search',
              name: 'search',
              pageBuilder: (context, state) =>
              const NoTransitionPage(child: UserSearchScreen()),
              routes: [
                GoRoute(
                  path: 'user',
                  name: 'user',
                  pageBuilder: (context, state) {
                    UserModel user = state.extra as UserModel;
                    return NoTransitionPage(child: UserPage(user: user));
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'my_page',
              name: 'my_page',
              pageBuilder: (context, state) =>
              const NoTransitionPage(child: MyPageScreen()),
              routes: [
                GoRoute(
                  path: 'edit_profile',
                  name: 'edit_profile',
                  builder: (context, state) {
                    UserModel user = state.extra as UserModel;
                    return EditUserScreen(user: user);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
