import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({super.key});

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final path = await CachingUtils.getSavedImagePath();
    setState(() {
      _imagePath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25.h,
      backgroundColor: AppColors.white,
      backgroundImage:
          _imagePath != null
              ? FileImage(File(_imagePath!))
              : const AssetImage('assets/images/user_placeholder.jpg')
                  as ImageProvider,
    );
  }
}
