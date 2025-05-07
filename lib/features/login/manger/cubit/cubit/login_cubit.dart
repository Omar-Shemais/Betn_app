import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/widgets/snack_bar.dart';
import 'package:furnitrue_app/features/home/presentation/view/widgets/home_navigation_bar.dart';
import 'package:furnitrue_app/features/login/data/model/login_model.dart';
import 'package:furnitrue_app/features/login/data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  LoginRepo loginRepo = LoginRepo();
  final formKey = GlobalKey<FormState>();
  String? name, password;
  void login({required String name, required String password}) async {
    emit(LoginLoading());
    try {
      final response = await loginRepo.login(name: name, password: password);

      if (response.status == "success") {
        await CachingUtils.cacheUser({
          'user': {'id': response.user!.id, 'name': response.user!.name},
          'token': response.token,
          'message': response.message,
        });

        emit(LoginSuccess(response));
        showSnackBar(response.message);
        RouteUtils.pushAndPopAll(const HomeNavigationBar());
      } else {
        emit(LoginError(errorMessage: response.message));
      }
    } catch (e) {
      emit(LoginError(errorMessage: 'حدث خطأ يرجى المحاولة لاحقاً'));
    }
  }
}


  




  // Future<void> login() async {
  //   formKey.currentState!.save();
  //   if (!formKey.currentState!.validate()) {
  //     return;
  //   }
  //   emit(LoginLoading());
  //   try {
  //     final response = await NetworkUtils.post(
  //       'auth/login.php',
  //       data: {'name': name, 'password': password},
  //     );
  //     if (response.statusCode == 200) {
  //       await CachingUtils.cacheUser(response.data);
  //       LoginResponseModel.fromJson(response.data);
  //       RouteUtils.pushAndPopAll(HomeView());

  //       emit(LoginSuccess());
  //     } else {
  //       showSnackBar('Somthing went wrong', isError: true);
  //       emit(LoginError());
  //     }
  //   } catch (e) {
  //     showSnackBar('An error occurred. Please try again.', isError: true);
  //     print(e.toString());
  //     emit(LoginError());
  //   }
  // }

