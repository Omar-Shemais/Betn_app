import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25.h,
      backgroundColor: AppColors.white,
      backgroundImage: const AssetImage('assets/images/user_placeholder.jpg'),
    );
  }
}
