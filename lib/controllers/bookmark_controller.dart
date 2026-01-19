import 'package:get/get.dart';

class BookmarkController extends GetxController {
  /// 북마크 리스트
  final RxList<Map<String, dynamic>> bookmarks = <Map<String, dynamic>>[].obs;

  /// 로딩 상태
  final RxBool isLoading = false.obs;

  /// 북마크 조회
  Future<void> loadBookmarks() async {
    isLoading.value = true;

    try {
      // TODO: 실제 API 연결
      await Future.delayed(const Duration(seconds: 1));

      // 임시 더미 데이터 (나중에 API 응답으로 교체)
      final response = [
        {
          "isClosed": false,
          "tags": ["#비흡연", "#A동"],
          "title": "A동 룸메 구해요",
          "user": "컴공23",
          "time": "10분 전",
          "imageIndex": 5,
        }
      ];

      bookmarks.assignAll(response);
    } catch (e) {
      bookmarks.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// 북마크 추가
  void addBookmark(Map<String, dynamic> item) {
    bookmarks.add(item);
  }

  /// 북마크 제거
  void removeBookmark(Map<String, dynamic> item) {
    bookmarks.remove(item);
  }
}
