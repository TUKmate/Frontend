import 'package:get/get.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import 'auth_controller.dart';

class PostController extends GetxController {
  final _api = Get.find<ApiService>();

  // 상태 변수
  final RxList<Post> posts = <Post>[].obs; // 게시물 목록
  final RxBool isLoading = false.obs; // 로딩 상태

  @override
  void onInit() {
    super.onInit();
    loadPosts(); // 초기화 시 게시물 불러오기
  }

  // 게시물 불러오기
  Future<void> loadPosts() async {
    isLoading.value = true;

    try {
      final data = await _api.getPosts();
      // json 배열 -> Post 객체 리스트 변환
      posts.value = data.map<Post>((json) => Post.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar('오류', '게시물을 불러오는 데 실패했습니다.');
    } finally {
      isLoading.value = false; // 성공이든 실패든 로딩 끝
    }
  }

  // 새 게시물 작성
  Future<bool> createPost({
    required String title,
    required String content,
    int? imageId,

    String? dorm_type,
    String? mbti_ie,
    String? mbti_ns,
    String? mbti_ft,
    String? mbti_jp,
    String? birth_year,
    String? enrollment_year,
    String? sleep_start,
    String? sleep_end,
    String? smoking,
    String? bug,
    String? shower_style,
    String? shower_duration,
    String? sleep_sensitivity,
    String? home_visit_cycle,
    String? sleep_habits,
    String? game,
    String? cleanliness,
    String? discord,
    String? invite_friends,
  }) async {
    // 빈 내용 체크
    if (content.trim().isEmpty) return false;

    try {
      final res = await _api.createPost(
        title: title,
        content: content,
        imageId: imageId,

        dorm_type: dorm_type,
        mbti_ie: mbti_ie,
        mbti_ns: mbti_ns,
        mbti_ft: mbti_ft,
        mbti_jp: mbti_jp,
        birth_year: birth_year,
        enrollment_year: enrollment_year,
        sleep_start: sleep_start,
        sleep_end: sleep_end,
        smoking: smoking,
        bug: bug,
        shower_style: shower_style,
        shower_duration: shower_duration,
        sleep_sensitivity: sleep_sensitivity,
        home_visit_cycle: home_visit_cycle,
        sleep_habits: sleep_habits,
        game: game,
        cleanliness: cleanliness,
        discord: discord,
        invite_friends: invite_friends,
      );

      print('DEBUG createPost: statusCode=${res.statusCode}');
      print('DEBUG createPost: body=${res.body}');

      if (res.statusCode == 201) {
        await loadPosts(); // 게시물 새로고침 (새 게시글이 보이도록)
        return true;
      } else {
        final errorMsg = res.body?['message'] ?? '알 수 없는 오류';
        print('DEBUG createPost: error=$errorMsg');
        Get.snackbar('오류', errorMsg);
        return false;
      }
    } catch (e) {
      print('DEBUG createPost: exception=$e');
      Get.snackbar('오류', '게시물 작성에 실패했습니다. $e');
      return false;
    }
  }

  // 게시물 삭제
  Future<void> deletePost(int id) async {
    try {
      final success = await _api.deletePost(id);
      if (success) {
        // 로컬 목록에서 해당 게시글 제거
        posts.removeWhere((post) => post.id == id);
        Get.snackbar('완료', '게시물이 삭제되었습니다.');
      }
    } catch (e) {
      Get.snackbar('오류', '게시물 삭제에 실패했습니다.');
    }
  }

  // 게시물 북마크 토글
  Future<void> toggleBookmark(int postId) async {
    try {
      final result = await _api.toggleBookmark(postId);
      if (result != null) {
        // 해당 게시글 찾기
        int index = posts.indexWhere((post) => post.id == postId);
        if (index != -1) {
          // 북마크 상태 업데이트
          posts[index] = posts[index].copyWith(
            isBookmarked: result['bookmarked'],
          );
        }
      }
    } catch (e) {
      Get.snackbar('오류', '북마크 실패');
    }
  }

  // 내가 쓴 글만 가져오기
  List<Post> get myPosts {
    final user = Get.find<AuthController>().user.value;
    if (user == null) return [];
    
    return posts
        .where((post) => post.userId == user.id)
        .toList();
}
}
