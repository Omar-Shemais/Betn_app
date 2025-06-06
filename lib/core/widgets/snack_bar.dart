import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';

void showSnackBar(
  String message, {
  bool isError = false,
  Color succColor = AppColors.primaryColor,
}) {
  ScaffoldMessenger.of(RouteUtils.context).hideCurrentSnackBar();
  ScaffoldMessenger.of(RouteUtils.context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : succColor,
      duration: const Duration(seconds: 3),
    ),
  );
}
