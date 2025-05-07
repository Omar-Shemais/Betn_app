import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/widgets/app_loading_indicator.dart';
import 'package:furnitrue_app/core/widgets/custom_button.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/custom_text_field.dart';
import 'package:furnitrue_app/core/widgets/divider.dart';
import 'package:furnitrue_app/core/widgets/snack_bar.dart';
import 'package:furnitrue_app/features/signup/manger/cubit/sign_up_cubit.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

bool isObsecure = false;

class _SignupViewBodyState extends State<SignupViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpError) {
          showSnackBar(state.errorMessage, isError: true);
        }
      },
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<SignUpCubit>(context);
          return Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(height: 60.height),
                    Image.asset(
                      'assets/images/sign_up.png',
                      width: 200.width,
                      height: 160.height,
                      fit: BoxFit.cover,
                    ),

                    SizedBox(height: 25),
                    AppText(
                      title: 'Create new account',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 25),
                    CustomTextField(
                      hint: 'Full name',
                      // validator: ValidatorUtils.name,
                      controller: nameController,
                      isObsecure: false,
                    ),
                    SizedBox(height: 20),

                    CustomTextField(
                      hint: 'Email',
                      // validator: ValidatorUtils.email,
                      controller: emailController,
                      isObsecure: false,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hint: 'Phone',
                      // validator: ValidatorUtils.phone,
                      controller: phoneController,
                      keyboardType: TextInputType.numberWithOptions(),
                      isObsecure: false,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hint: 'Address',
                      controller: addressController,
                      // validator: ValidatorUtils.email,
                      isObsecure: false,
                    ),

                    SizedBox(height: 20),

                    CustomTextField(
                      isObsecure: isObsecure,
                      hint: 'password',
                      controller: passwordController,
                      // validator: ValidatorUtils.password,
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
                    SizedBox(height: 25.height),

                    BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        if (state is SignUpLoading) {
                          return const Center(child: AppLoadingIndicator());
                        }

                        return AppButton(
                          btnText: 'Verify',
                          width: double.infinity,
                          height: 50.height,
                          onTap: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.signUp(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                password: passwordController.text,
                              );
                            }
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
                          title: 'Already have an account?',
                          fontSize: 16,
                        ),
                        SizedBox(width: 5.width),
                        InkWell(
                          onTap: () => RouteUtils.pop(),
                          child: const AppText(
                            title: ' Log in',
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.height),
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
