import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/images/user_placeholder.jpg'),
        ),
        SizedBox(width: 8.width),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              title: CachingUtils.name,

              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            AppText(
              title: 'xxxxx@gmail.com',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.lightTextColor,
            ),
          ],
        ),
      ],
    );
  }
}
