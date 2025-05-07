import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/utils/validator_utils/validator_utils.dart';
import 'package:furnitrue_app/core/widgets/app_loading_indicator.dart';
import 'package:furnitrue_app/core/widgets/custom_button.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/custom_text_field.dart';
import 'package:furnitrue_app/core/widgets/divider.dart';
import 'package:furnitrue_app/core/widgets/snack_bar.dart';
import 'package:furnitrue_app/features/login/manger/cubit/cubit/login_cubit.dart';
import 'package:furnitrue_app/features/login/presentation/view/forget_password_view.dart';
import 'package:furnitrue_app/features/signup/presentation/view/signup_view.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

bool isObsecure = false;

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          showSnackBar(state.errorMessage, isError: true);
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<LoginCubit>(context);
          return Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(height: 60.height),
                    Image.asset(
                      'assets/images/login.png',
                      width: 200.width,
                      height: 160.height,
                      fit: BoxFit.cover,
                    ),

                    SizedBox(height: 25),
                    AppText(
                      title: 'Log in your account',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 25),
                    CustomTextField(
                      hint: 'name',
                      controller: emailController,
                      onChange: (value) => cubit.name = value,
                      validator: ValidatorUtils.name,
                      isObsecure: false,
                    ),

                    SizedBox(height: 20),

                    CustomTextField(
                      isObsecure: isObsecure,
                      hint: 'password',
                      onChange: (value) => cubit.password = value,
                      controller: passwordController,
                      validator: ValidatorUtils.password,
                      onTap: () {
                        setState(() {
                          isObsecure = !isObsecure;
                        });
                      },
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 5.width),
                        child: Icon(
                          isObsecure ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.lightTextColor,
                          size: 20.width,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => RouteUtils.push(ForgetPasswordView()),
                          child: const AppText(
                            title: 'forgot password?',
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 25.height),
                      ],
                    ),
                    SizedBox(height: 25.height),

                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const Center(child: AppLoadingIndicator());
                        }
                        return AppButton(
                          btnText: 'Log in',
                          width: double.infinity,
                          height: 50.height,
                          onTap: () {
                            cubit.login(
                              name: emailController.text,
                              password: passwordController.text,
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 32.height),
                    const CustomDivider(text: 'Or'),
                    SizedBox(height: 15.height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/google.png',
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 15.width),
                        Image.asset(
                          'assets/icons/facebook.png',
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 15.width),
                        Image.asset(
                          'assets/icons/twitter.png',
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText(
                          title: 'Don’t have an account?',
                          fontSize: 16,
                        ),
                        SizedBox(width: 5.width),
                        InkWell(
                          onTap: () => RouteUtils.push(SignUpView()),
                          child: const AppText(
                            title: 'Sign up',
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
