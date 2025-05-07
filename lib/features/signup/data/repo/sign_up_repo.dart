import 'package:dio/dio.dart';
import 'package:furnitrue_app/core/utils/network_utils/network_utils.dart';
import 'package:furnitrue_app/features/signup/data/models/signup_response_model.dart';

class SignUpRepo {
  Future<SignUpResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    try {
      final response = await NetworkUtils.post(
        "auth/register.php",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "address": address,
          "phone": phone,
        },
      );

      if (response.statusCode == 200) {
        return SignUpResponseModel.fromJson(response.data);
      } else {
        return SignUpResponseModel(
          status: "error",
          message: response.data["errors"].toString(),
        );
      }
    } on DioException catch (error) {
      final res = error.response;
      if (res != null) {
        if (res.statusCode == 409) {
          return SignUpResponseModel.fromJson(res.data);
        }
        if (res.statusCode == 500) {
          return SignUpResponseModel(
            status: "error",
            message: "Check your parameters.",
          );
        }
        return SignUpResponseModel.fromJson(res.data);
      } else {
        return SignUpResponseModel(
          status: "error",
          message: error.message ?? "Check your internet connection.",
        );
      }
    }
  }
}
