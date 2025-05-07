import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/widgets/app_dialog.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/features/login/presentation/view/login_view.dart';
import 'package:furnitrue_app/features/profile/presentation/view/widgets/edit_profile_view.dart';
import 'package:furnitrue_app/features/profile/presentation/view/widgets/profile_item.dart';
import 'package:furnitrue_app/features/profile/presentation/view/widgets/user_info.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Center(
        child: Column(
          spacing: 20.height,
          children: [
            SizedBox(height: 20.height),
            AppText(
              title: 'My Profile',
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserInfo(),
                IconButton(
                  onPressed: () => RouteUtils.push(EditProfileView()),
                  icon: SvgPicture.asset('assets/icons/edit_icon.svg'),
                ),
              ],
            ),
            Divider(),
            PofileItem(
              leadingIcon: Icons.battery_charging_full,
              text: 'History of order',
              onTap: () {},
            ),
            PofileItem(
              leadingIcon: Icons.credit_card,
              text: 'Payment methods',
              onTap: () {},
            ),
            PofileItem(
              leadingIcon: Icons.notifications_none_outlined,
              text: 'Notifications',
              onTap: () {},
            ),
            PofileItem(
              leadingIcon: CupertinoIcons.arrow_2_circlepath,
              text: 'Reward card',
              onTap: () {},
            ),
            PofileItem(
              leadingIcon: Icons.battery_charging_full,
              text: 'History of order',
              onTap: () {},
            ),
            PofileItem(
              leadingIcon: Icons.abc,
              text: 'Promo code',
              onTap: () {},
            ),
            PofileItem(
              leadingIcon: Icons.privacy_tip_outlined,
              text: 'Privacy & policy',
              onTap: () {},
            ),
            PofileItem(
              leadingIcon: Icons.language,
              text: 'Language',
              onTap: () {},
            ),
            PofileItem(
              leadingIcon: Icons.help_outline,
              text: 'Help',
              onTap: () {},
              showTrailingIcon: false,
            ),
            PofileItem(
              leadingIcon: Icons.login,
              text: 'Log out',
              showTrailingIcon: false,
              onTap: () async {
                AppDialog.show(
                  context,
                  message: 'Are you sure you want to log out?',
                  confirmTitle: 'Log out',
                  onConfirm: () {
                    CachingUtils.deleteUser();
                    RouteUtils.pushAndPopAll(const LoginView());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
