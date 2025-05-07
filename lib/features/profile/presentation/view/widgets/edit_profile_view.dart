import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/features/profile/presentation/view/widgets/custom_phone_field.dart';
import 'package:furnitrue_app/core/widgets/custom_text_field.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50.h),

              Row(
                children: [
                  IconButton(
                    onPressed: () => RouteUtils.pop(),
                    icon: Icon(Icons.arrow_back_ios, size: 24.sp),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'My profile',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 48.w),
                ],
              ),

              SizedBox(height: 20.h),

              // Profile Picture
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: AssetImage(
                      'assets/images/user_placeholder.jpg',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        size: 20.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              // Full Name
              CustomTextField(
                hint: CachingUtils.name,
                borderRadius: BorderRadius.circular(12.r),
              ),
              SizedBox(height: 16.h),

              // Phone Number
              Row(
                children: [
                  SizedBox(width: 120.w, child: CustomPhoneField()),
                  SizedBox(width: 8.w),
                  Expanded(child: CustomTextField(hint: 'Phone')),
                ],
              ),

              SizedBox(height: 16.h),

              // Email
              CustomTextField(
                hint: 'Email',
                borderRadius: BorderRadius.circular(12.r),
              ),
              SizedBox(height: 16.h),

              // Address
              CustomTextField(
                hint: 'Address',
                borderRadius: BorderRadius.circular(12.r),
              ),
              SizedBox(height: 40.h),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
