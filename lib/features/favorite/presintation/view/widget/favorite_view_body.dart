import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/widgets/app_app_bar.dart';
import 'package:furnitrue_app/core/widgets/custom_button.dart';
import 'package:furnitrue_app/core/widgets/custom_plus_icon.dart';
import 'package:furnitrue_app/core/widgets/custom_text_field.dart';
import 'package:furnitrue_app/features/cart/presentation/view/widgets/my_cart_container.dart';
import 'package:furnitrue_app/features/search/presintation/view/search_view.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 46.h),
          AppAppBar(title: 'Favorite'),
          SizedBox(height: 36.h),
          CustomTextField(
            readOnly: true,
            onTap: () => RouteUtils.push(SearchView()),
            hint: 'Search',
            prefixIcon: Icon(Icons.search, color: AppColors.lightTextColor),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(14),
              child: SizedBox(
                child: SvgPicture.asset(
                  'assets/icons/mic_icon.svg',
                  width: 15.w,
                  height: 15.h,
                ),
              ),
            ),
          ),
          SizedBox(height: 25.h),
          MyCartContainer(
            image: 'assets/images/cart_placeholder.png',
            title: 'Chair',
            price: '20000',
            addProductIcon: CustomPlusIcon(),
          ),
          SizedBox(height: 43.h),
          AppButton(btnText: 'Add all item to cart ', width: double.infinity),
        ],
      ),
    );
  }
}
