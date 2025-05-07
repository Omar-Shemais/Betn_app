import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/utils/validator_utils/validator_utils.dart';
import 'package:furnitrue_app/core/widgets/custom_button.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/custom_text_field.dart';
import 'package:furnitrue_app/features/login/presentation/view/password_code_view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 60.height),

            Image.asset(
              'assets/images/forget_password.png',
              width: 200.width,
              height: 160.height,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 25),
            AppText(
              title: 'Forgot password',
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 25),
            CustomTextField(
              hint: 'Email or Phone',
              validator: ValidatorUtils.email,
              isObsecure: false,
            ),
            SizedBox(height: 25.height),
            AppButton(
              btnText: 'Continue',
              width: double.infinity,
              height: 50.height,
              onTap: () {
                RouteUtils.push(PasswordCodeView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
