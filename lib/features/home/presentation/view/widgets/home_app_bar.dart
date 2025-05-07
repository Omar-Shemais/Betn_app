import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/user_avatar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(title: 'Let’s furnish your ', fontSize: 24),
            AppText(title: 'home', fontSize: 24),
          ],
        ),
        UserAvatar(),
      ],
    );
  }
}
