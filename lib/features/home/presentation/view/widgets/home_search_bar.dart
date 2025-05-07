import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/widgets/custom_text_field.dart';
import 'package:furnitrue_app/features/home/presentation/view/widgets/notification_view.dart';
import 'package:furnitrue_app/features/search/presintation/view/search_view.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => RouteUtils.push(NotificationView()),
          child: SvgPicture.asset(
            'assets/icons/pajamas_notifications.svg',
            width: 24.width,
            height: 24.height,
          ),
        ),
        SizedBox(width: 15.width),
        Expanded(
          child: CustomTextField(
            borderRadius: BorderRadius.circular(20),
            onTap: () => RouteUtils.push(SearchView()),
            readOnly: true,
            hint: 'Search',
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.lightTextColor,
              size: 22.width,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(14),
              child: SizedBox(
                width: 60.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/mic_icon.svg',
                      width: 15.width,
                      height: 15.height,
                    ),
                    SizedBox(width: 10.width),
                    SvgPicture.asset(
                      'assets/icons/camer_icon.svg',
                      width: 15.width,
                      height: 15.height,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
