import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/features/login/presentation/view/login_view.dart';
import 'package:furnitrue_app/features/signup/data/models/signup_response_model.dart';
import 'package:furnitrue_app/features/signup/data/repo/sign_up_repo.dart';
import '../../../../core/utils/caching_utils/caching_utils.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final SignUpRepo signUpRepo = SignUpRepo();
  final formKey = GlobalKey<FormState>();
  String? name, emailOrPhone, password, address;
  int? phone;
  void signUp({
    required name,
    required email,
    required password,
    required phone,
    required address,
  }) async {
    emit(SignUpLoading());
    final SignUpResponseModel response = await signUpRepo.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
      address: address,
    );

    if (response.status == 'success') {
      emit(SignUpSuccess(message: response.message ?? "تم التسجيل بنجاح"));
      RouteUtils.pushAndPopAll(LoginView());
      CachingUtils.saveUserData({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
      });
    } else {
      final errorMsg =
          response.errors?.values.first ??
          response.message ??
          "حدث خطأ غير متوقع.";
      emit(SignUpError(errorMessage: errorMsg.toString()));
    }
  }
}
