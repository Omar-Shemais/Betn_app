import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnitrue_app/features/signup/manger/cubit/sign_up_cubit.dart';
import 'package:furnitrue_app/features/signup/presentation/view/widgets/signup_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => SignUpCubit(),
        child: SignupViewBody(),
      ),
    );
  }
}
