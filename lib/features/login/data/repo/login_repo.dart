import 'package:dio/dio.dart';
import 'package:furnitrue_app/core/utils/network_utils/network_utils.dart';
import 'package:furnitrue_app/features/login/data/model/login_model.dart';

class LoginRepo {
  Future<LoginResponseModel> login({
    required String name,
    required String password,
  }) async {
    try {
      final response = await NetworkUtils.post(
        "auth/login.php",
        data: {"name": name, "password": password},
      );

      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.response != null) {
        return LoginResponseModel.fromJson(e.response!.data);
      }
      rethrow;
    }
  }
}













/*
class LoginRepo {
  Future<LoginResponseModel> login({
    required String name,
    required String password,
  }) async {
    try {
      final response = await NetworkUtils.post(
        "auth/login.php",
        data: {"name": name, "password": password},
      );
      final loginModel = LoginResponseModel.fromJson(response.data);
      return loginModel;
    } on DioException catch (error) {
      final message = error.response!.data["message"] ?? "Login failed";
      throw (message);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
*/