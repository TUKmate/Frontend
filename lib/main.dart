import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tukmate_flutter/controllers/bookmark_controller.dart';
import '../controllers/auth_controller.dart';

import 'app.dart';
import 'controllers/post_controller.dart';
import 'services/api_service.dart';

void main() async {
  // Flutter 엔진과 위젯 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // 의존성 주입 (순서 중요)
  Get.put(ApiService());  // 1. API 서비스
  Get.put(AuthController());  // 2. 인증 컨트롤러
  Get.put(PostController()); // 3. 트윗
  Get.put(BookmarkController()); // 4. 북마크

  // 한국어 설정
  timeago.setLocaleMessages('ko', timeago.KoMessages());

  // 앱 실행
  runApp(const MyApp());
}