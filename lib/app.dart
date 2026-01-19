import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'models/post.dart';
import 'models/user.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/profile_edit_screen.dart';
import 'screens/compose_screen.dart';
import 'screens/post_screen.dart';
import 'screens/bookmark_screen.dart';
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


      initialRoute: '/',


      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/home', page: () => HomeScreen(user: Get.find<AuthController>().user.value!)),
        GetPage(name: '/profile', page: () => ProfileScreen(user: Get.find<AuthController>().user.value!)),
        GetPage(name: '/profile_edit', page: () => const ProfileEditScreen()),
        GetPage(name: '/compose', page: () => const ComposeScreen()),
        GetPage(name: '/post', page: () {
          final args = Get.arguments as Map<String, dynamic>;
          final post = args['post'] as Post;
          final user = args['user'] as User;
          return PostScreen(post: post, user: user);
        }),
        GetPage(name: '/post_edit', page: () {
          final postId = Get.arguments as int;
          return PostEditScreen(postId: postId);
        }),
        GetPage(name: '/bookmark', page: () => const BookmarkScreen()),
        GetPage(name: '/my_posts', page: () => MyPostsScreen(user: Get.find<AuthController>().user.value!)),
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
