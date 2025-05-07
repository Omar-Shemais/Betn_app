import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneField extends StatelessWidget {
  final Function(String)? onChanged;
  final String? initialCountryCode;

  const CustomPhoneField({
    super.key,
    this.onChanged,
    this.initialCountryCode = 'EG',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.offWhite,
      ),

      child: IntlPhoneField(
        initialCountryCode: initialCountryCode,
        // dropdownIconPosition: IconPosition.trailing,
        onChanged: (phone) {
          print(phone.countryCode); // Only country code
        },
      ),
    );
  }
}
