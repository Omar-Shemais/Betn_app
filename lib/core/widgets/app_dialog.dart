import 'package:flutter/material.dart';

import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
import 'package:furnitrue_app/core/widgets/custom_button.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.message,
    required this.confirmTitle,
    required this.onConfirm,
    this.onCancel,
  });

  static void show(
    BuildContext context, {
    required String message,
    String confirmTitle = 'Save',
    required void Function() onConfirm,
    void Function()? onCancel,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      // ignore: deprecated_member_use
      barrierColor: AppColors.black.withOpacity(0.5),
      builder:
          (context) => AppDialog(
            message: message,
            confirmTitle: confirmTitle,
            onConfirm: onConfirm,
            onCancel: onCancel,
          ),
    );
  }

  final String message;
  final String confirmTitle;
  final void Function() onConfirm;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.width,
          vertical: 24.height,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            AppText(
              title: 'Log out',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              textAlign: TextAlign.center,
            ),
            AppText(
              title: message,
              color: AppColors.lightTextColor,
              textAlign: TextAlign.center,
            ),

            AppButton(
              btnText: 'Log out',
              textColor: AppColors.primaryColor,
              onTap: onConfirm,
              btnColor: AppColors.white,
              width: double.infinity,
            ),

            AppButton(
              btnText: 'Cancel',
              width: double.infinity,
              onTap: () {
                if (onCancel == null) {
                  Navigator.pop(context);
                  return;
                }
                onCancel!();
              },
            ),
          ],
        ),
      ),
    );
  }
}
