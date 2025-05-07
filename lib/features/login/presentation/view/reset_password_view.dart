import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/utils/validator_utils/validator_utils.dart';
import 'package:furnitrue_app/core/widgets/custom_button.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/custom_text_field.dart';
import 'package:furnitrue_app/features/login/presentation/view/login_view.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 60.height),

            Image.asset(
              'assets/images/reset_password.png',
              width: 200.width,
              height: 160.height,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 25),
            AppText(
              title: 'Reset password',
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 25),
            CustomTextField(
              hint: 'New password',
              validator: ValidatorUtils.password,
              isObsecure: false,
            ),
            SizedBox(height: 25.height),
            CustomTextField(
              hint: 'Confirm Password',
              validator: ValidatorUtils.password,
              isObsecure: false,
            ),
            SizedBox(height: 25.height),
            AppButton(
              btnText: 'Reset',
              width: double.infinity,
              height: 50.height,
              onTap: () {
                RouteUtils.pushAndPopAll(LoginView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
