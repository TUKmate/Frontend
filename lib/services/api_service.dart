import 'package:get/get.dart';

///
/// api 통신을 하기위한 기본 클래스
/// 
class ApiService extends GetConnect {
  String? _token;  // 통신에 사용할 인증 Token 저장

  @override
  void onInit() {
    // 서버 주소 설정 (나중에 내 서버가 생기면 그쪽의 ip나 Domain으로 전환)
    httpClient.baseUrl = 'http://localhost:3000/api';
    httpClient.timeout = const Duration(seconds: 30); // API 요청 최대 대기 시간

    // 토큰 자동 첨부
    httpClient.addRequestModifier<dynamic>((request) async {
      if (_token != null) {
        request.headers['Authorization'] = 'Bearer $_token';
      }
      return request;
    });

    super.onInit();  // 부모(GetConnect)의 초기화도 반드시 실행
  }

  // 로그인 성공시 토큰 저장
  void setToken(String? token) {
    _token = token;
 }

  // 로그아웃시 토큰 삭제
  void clearToken() {
    _token = null;
  }

  // 회원가입
  Future<Response> register({
    required String id,
    required String password,
    required String name,
    required String username,
  }) async {
    return await post('/auth/register', {
      'id' : id,
      'password' : password,
      'name' : name,
      'username' : username,
    });
  }

  // 로그인
  Future<Map<String, dynamic>?> login({
    required String id,
    required String password,
  }) async {
    final res = await post('/auth/login', {
      'id' : id,
      'password' : password,
    });
    print('Login Response: ${res.bodyString}'); // 디버그용 출력

    if (res.statusCode == 200) {
      final token = res.body['token'];
      setToken(token);  // 토큰 저장 (이후 요청에 자동 첨부됨)

      return res.body['user'];  // 유저 정보 반환
    }
    return null;  // 로그인 실패
  }

  // 내 프로필 조회
  Future<Map<String, dynamic>?> getMyProfile() async {
  final res = await get('/users/me');
  if (res.statusCode == 200) {
    return res.body['data'];  // 유저 정보 반환
  }
  return null;
  }

  // 내가 쓴 트윗 목록
  Future<List<dynamic>> getMyPosts() async {
  final res = await get('/users/me/posts');
  if (res.statusCode == 200) {
    return res.body['data'] ?? [];
  }
  return [];
  }

  // 타임라인 조회 : 모든 게시글 가져오기
  Future<List<dynamic>> getPosts() async {
    final res = await get('/posts');
    if (res.statusCode == 200) {
      return res.body['data'] ?? [];
    }
    return [];
  }

  // 게시글 작성
  Future<Response> createPost(String content, String? imagePath) async {
    return await post('/posts', {
      'content': content,
      'image': imagePath,
    });
  }

  // 게시글 삭제
  Future<bool> deletePost(int id) async {
    final res = await delete('/posts/$id');
    return res.statusCode == 200;
  }

  // 북마크 토글 : 누르면 북마크, 다시 누르면 취소
  Future<Map<String, dynamic>?> toggleBookmark(int postId) async {
    final res = await post('/posts/$postId/bookmark', {});
    if (res.statusCode == 200) {
      return res.body;
    }
    return null;
  }

  // 내 프로필 조회
  Future<Map<String, dynamic>?> getProfile(int userId) async {
    final res = await get('/users/me');
    if (res.statusCode == 200) {
      return res.body['data'];  // 유저 정보 반환
    }
    return null;
  }

  // 내가 쓴 게시글 목록
  Future<List<dynamic>> getUserPosts(int userId) async {
    final res = await get('/users/me/posts');
    if (res.statusCode == 200) {
      return res.body['data'] ?? [];
    }
    return [];
  }
}