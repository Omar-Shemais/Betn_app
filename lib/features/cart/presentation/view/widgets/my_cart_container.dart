import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/features/favorite/manger/cubit/favorite_cubit.dart';
import 'package:furnitrue_app/features/home/data/model/prouduct_response_model.dart';

class MyCartContainer extends StatefulWidget {
  const MyCartContainer({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.addProductIcon,
    required this.product,
    this.onPressed,
  });

  final String image, title, price;
  final Widget addProductIcon;
  final Product product;
  final void Function(BuildContext)? onPressed;

  @override
  State<MyCartContainer> createState() => _MyCartContainerState();
}

class _MyCartContainerState extends State<MyCartContainer> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: .15,
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: widget.onPressed,
            backgroundColor: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
      child: Row(
        children: [
          /// 🖤 Image with Favorite Icon
          Stack(
            children: [
              Container(
                color: AppColors.offWhite,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r),
                  ),
                  child:
                      widget.product.images.isNotEmpty
                          ? Image.network(
                            widget.image,
                            width: .4.sw,
                            height: 120.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/cart_placeholder.png',
                                width: .4.sw,
                                height: 120.h,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                          : Image.asset(
                            'assets/images/cart_placeholder.png',
                            width: .4.sw,
                            height: 120.h,
                            fit: BoxFit.cover,
                          ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    final cubit = context.read<FavoriteCubit>();
                    final isFavorite = context.read<FavoriteCubit>().isFavorite(
                      widget.product,
                    );

                    return GestureDetector(
                      onTap: () {
                        cubit.toggleFavorite(widget.product);
                        setState(() {});
                      },
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: AppColors.primaryColor,
                        size: 24,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          /// 🛒 Info Container
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
                      AppText(
                        title: widget.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 9.w),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        title: widget.price,
                        maxLines: 1,
                        fontSize: 14.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      widget.addProductIcon,
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
