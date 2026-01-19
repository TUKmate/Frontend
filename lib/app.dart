import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/profile_edit_screen.dart';
import 'screens/compose_screen.dart';
import 'screens/main_screen.dart';
import 'screens/post_screen.dart';
import 'screens/bookmark_screen.dart';
import 'screens/bookmark_empty_screen.dart';
import 'screens/post_edit_screen.dart';
import 'screens/my_posts_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TUKmate',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      initialRoute: '/profile',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/profile_edit', page: () => const ProfileEditScreen()),
        GetPage(name: '/compose', page: () => const ComposeScreen()),
        GetPage(name: '/main', page: () => const MainScreen()),
        GetPage(name: '/post', page: () => const PostScreen()),
        GetPage(name: '/post_edit', page: () => const PostEditScreen()),
        GetPage(name: '/bookmark', page: () => const BookmarkScreen()),
        GetPage(
          name: '/bookmark_empty',
          page: () => const BookmarkEmptyScreen(),
        ),
        GetPage(name: '/my_posts', page: () => const MyPostsScreen()),
      ],
    );
  }

  // 앱 테마 설정
  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    );
  }
}
