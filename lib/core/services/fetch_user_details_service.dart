import 'package:dio/dio.dart';
import 'package:perfection_company/home/model/user_model.dart';

class UserService {
  final Dio _dio = Dio();

  Future<List<User>> fetchUsers(int page) async {
    final response = await _dio
        .get('https://reqres.in/api/users', queryParameters: {'page': page});
    if (response.statusCode == 200) {
      List<dynamic> data = response.data['data'];
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> fetchUserDetails(int id) async {
    final response = await _dio.get('https://reqres.in/api/users/$id');
    if (response.statusCode == 200) {
      return User.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
