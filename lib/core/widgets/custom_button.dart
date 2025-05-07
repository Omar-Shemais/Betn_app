// import 'package:flutter/material.dart';
// import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
// import 'package:furnitrue_app/core/widgets/app_loading_indicator.dart';
// import 'package:furnitrue_app/core/widgets/custom_text.dart';
// import '../utils/app_colors/app_colors.dart';

// class CustomButton extends StatelessWidget {
//   const CustomButton({
//     super.key,
//     required this.btnText,
//     this.onTap,
//     this.width = 150,
//     this.height = 45,
//     this.borderRadius,
//     this.isLoading = false,
//     this.btnColor = AppColors.primaryColor,
//     this.textColor = AppColors.white,
//   });
//   final String btnText;
//   final void Function()? onTap;

//   final double width;
//   final double height;
//   final BorderRadiusGeometry? borderRadius;
//   final bool isLoading;
//   final Color? btnColor;
//   final Color? textColor;

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const AppLoadingIndicator();
//     }
//     return Center(
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           height: height.height,
//           width: width.width,
//           decoration: BoxDecoration(
//             color: btnColor,
//             borderRadius: BorderRadius.circular(16),
//           ),

//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: AppText(
//                   title: btnText,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: textColor!,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
import 'package:furnitrue_app/core/widgets/app_loading_indicator.dart';
import '../utils/app_colors/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.btnText,
    this.onTap,
    this.width = 150,
    this.height = 45,
    this.borderRadius,
    this.isLoading = false,
    this.btnColor = AppColors.primaryColor,
    this.textColor = AppColors.white,
    this.icon,
    this.iconSpacing = 8,
  });

  final String btnText;
  final void Function()? onTap;
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final bool isLoading;
  final Color? btnColor;
  final Color? textColor;
  final Widget? icon;
  final double iconSpacing;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const AppLoadingIndicator();

    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height.height,
          width: width.width,
          decoration: BoxDecoration(
            color: btnColor,
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            border: Border.all(color: AppColors.primaryColor, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                btnText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              if (icon != null) ...[SizedBox(width: iconSpacing.width), icon!],
            ],
          ),
        ),
      ),
    );
  }
}
