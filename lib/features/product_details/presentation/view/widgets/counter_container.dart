import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';

class CounterContainer extends StatefulWidget {
  final Function(int) onQuantityChanged;
  const CounterContainer({super.key, required this.onQuantityChanged});

  @override
  State<CounterContainer> createState() => _CounterContainerState();
}

class _CounterContainerState extends State<CounterContainer> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 55.h,
      decoration: ShapeDecoration(
        color: AppColors.lightGreen,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 5, color: Colors.white),
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                quantity++;
              });
              widget.onQuantityChanged(quantity);
            },
            child: _buildIcon(Icons.add),
          ),
          AppText(title: quantity.toString(), color: AppColors.white),
          InkWell(
            onTap: () {
              if (quantity > 1) {
                setState(() {
                  quantity--;
                });
                widget.onQuantityChanged(quantity);
              }
            },
            child: _buildIcon(Icons.remove),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(icon, color: AppColors.primaryColor, size: 25.sp),
    );
  }
}
