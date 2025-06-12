import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';
import 'package:furnitrue_app/core/widgets/app_loading_indicator.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/snack_bar.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';
import 'package:furnitrue_app/features/favorite/manger/cubit/favorite_cubit.dart';
import 'package:furnitrue_app/features/home/manger/Categories_cubit/cubit/category_cubit.dart';
import 'package:furnitrue_app/features/home/manger/Categories_cubit/cubit/category_state.dart';
import 'package:furnitrue_app/features/home/manger/product_cubit/cubit/product_cubit.dart';
import 'package:furnitrue_app/features/home/manger/product_cubit/cubit/product_state.dart';
import 'package:furnitrue_app/features/home/presentation/view/widgets/catagory_button.dart';
import 'package:furnitrue_app/features/home/presentation/view/widgets/home_app_bar.dart';
import 'package:furnitrue_app/features/home/presentation/view/widgets/home_search_bar.dart';
import 'package:furnitrue_app/features/home/presentation/view/widgets/item_cart.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    context.read<FavoriteCubit>().loadFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 40.height),
            HomeAppBar(),
            SizedBox(height: 25.height),
            HomeSearchBar(),
            SizedBox(height: 25.height),

            Container(
              height: 200.height,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.secondaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    Image.asset('assets/images/30% OFF.png'),
                    Image.asset('assets/images/lounge-chair.png'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppText(
                  title: 'See all',
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: 18.h),

            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesSuccess) {
                  final categories = state.categoriesModel.categories;
                  final selectedIndex = state.selectedIndex;
                  return SizedBox(
                    height: 40.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder:
                          (context, index) => SizedBox(width: 8.w),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoryButton(
                          name: category.name,
                          isSelected: selectedIndex == index,
                          onTap: () {
                            context.read<CategoriesCubit>().selectCategory(
                              index,
                            );
                            final selectedCategoryName = category.name;
                            context.read<ProductCubit>().filterByCategory(
                              selectedCategoryName,
                            );
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: AppLoadingIndicator());
                }
              },
            ),

            SizedBox(height: 25.height),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, catState) {
                String categoryName = 'Category';

                if (catState is CategoriesSuccess) {
                  categoryName =
                      catState
                          .categoriesModel
                          .categories[catState.selectedIndex]
                          .name;
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      title: categoryName,
                      fontSize: 20,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    const AppText(
                      title: 'See all',
                      fontSize: 16,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                );
              },
            ),

            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: AppLoadingIndicator());
                } else if (state is ProductLoaded) {
                  if (state.products.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(height: 50.h),
                        AppText(
                          title: 'No products available for this category',
                          fontSize: 16,
                          color: AppColors.lightTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    );
                  }
                  return SizedBox(
                    height: 204.height,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return ItemCart(
                          product: state.products[index],
                          onPlusTap: () {
                            final userId = CachingUtils.userID;
                            context.read<CartCubit>().addToCart(
                              userId,
                              state.products[index].id,
                              1,
                            );
                            showSnackBar("تمت الإضافة إلى السلة");
                          },
                        );
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(width: 8.w),
                    ),
                  );
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
