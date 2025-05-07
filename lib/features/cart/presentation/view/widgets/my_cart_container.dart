import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';

class MyCartContainer extends StatelessWidget {
  const MyCartContainer({
    super.key,
    required this.image,
    required this.title,
    required this.price,

    required this.addProductIcon,
    this.onPressed,
  });

  final String image, title, price;
  final Widget addProductIcon;
  final void Function(BuildContext)? onPressed;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: .15,
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: onPressed,
            backgroundColor: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: .4.sw,
            height: 120.h,
            decoration: BoxDecoration(
              color: AppColors.offWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r),
              ),
              image: DecorationImage(
                alignment: Alignment.center,
                fit: BoxFit.contain,
                image: AssetImage(image),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 120.h,
              padding: EdgeInsets.only(left: 8.w, right: 16.w, top: 24.h),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText(title: title, overflow: TextOverflow.ellipsis),
                      SizedBox(width: 9.w),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        title: price,
                        maxLines: 1,
                        fontSize: 14.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      addProductIcon,
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
