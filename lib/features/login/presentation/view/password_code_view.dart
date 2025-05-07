import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/utils/validator_utils/validator_utils.dart';
import 'package:furnitrue_app/core/widgets/custom_button.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/custom_text_field.dart';
import 'package:furnitrue_app/features/login/presentation/view/reset_password_view.dart';

class PasswordCodeView extends StatefulWidget {
  const PasswordCodeView({super.key});

  @override
  State<PasswordCodeView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<PasswordCodeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 60.height),

            Image.asset(
              'assets/images/password_code.png',
              width: 200.width,
              height: 160.height,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 25),
            AppText(
              title: 'Enter code',
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return CustomTextField(
                  hint: '',
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: ValidatorUtils.email,
                  width: 50.width,
                  isObsecure: false,
                  hasUnderline: true,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                );
              }),
            ),
            SizedBox(height: 15.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: const AppText(
                    title: 'Resend code?',
                    color: AppColors.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.height),
            AppButton(
              btnText: 'Continue',
              width: double.infinity,
              height: 50.height,
              onTap: () {
                RouteUtils.push(ResetPasswordView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
