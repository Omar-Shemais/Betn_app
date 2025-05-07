import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnitrue_app/features/login/manger/cubit/cubit/login_cubit.dart';
import 'package:furnitrue_app/features/login/presentation/view/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: LoginViewBody(),
      ),
    );
  }
}
