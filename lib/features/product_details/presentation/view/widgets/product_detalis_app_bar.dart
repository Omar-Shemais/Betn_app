import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';

class ProductDetalisAppBar extends StatelessWidget {
  const ProductDetalisAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => RouteUtils.pop(),
            icon: Icon(CupertinoIcons.back),
            iconSize: 30.sp,
          ),
          // Icon(
          //   Icons.favorite_border_outlined,
          //   color: AppColors.primaryColor,
          //   size: 40.sp,
          // ),
        ],
      ),
    );
  }
}
