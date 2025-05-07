import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/custom_text_field.dart';
import 'package:furnitrue_app/features/search/presintation/view/widget/search_container.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 50.h),
          Row(
            children: [
              IconButton(
                onPressed: RouteUtils.pop,
                icon: Icon(Icons.arrow_back_ios, size: 25.sp),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: CustomTextField(
                  borderRadius: BorderRadius.circular(20),

                  hint: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.lightTextColor,
                    size: 22.w,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      'assets/icons/mic_icon.svg',
                      width: 15.w,
                      height: 15.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              AppText(
                title: 'Popular search',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (context, index) => SizedBox(width: 15.w),
              itemBuilder: (context, index) {
                return SearchContainer();
              },
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (context, index) => SizedBox(width: 15.w),
              itemBuilder: (context, index) {
                return SearchContainer();
              },
            ),
          ),
        ],
      ),
    );
  }
}
