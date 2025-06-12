import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/widgets/app_app_bar.dart';
import 'package:furnitrue_app/core/widgets/app_loading_indicator.dart';
import 'package:furnitrue_app/core/widgets/custom_button.dart';
import 'package:furnitrue_app/core/widgets/snack_bar.dart';
import 'package:furnitrue_app/features/cart/data/model/cart_model.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';
import 'package:furnitrue_app/features/cart/manger/payment_cubit/payment_cubit.dart';
import 'package:furnitrue_app/features/cart/presentation/view/widgets/cart_counter_container.dart';
import 'package:furnitrue_app/features/cart/presentation/view/widgets/my_cart_container.dart';
import 'package:furnitrue_app/features/cart/presentation/view/widgets/total_price.dart';
import 'package:furnitrue_app/features/favorite/manger/cubit/favorite_cubit.dart';
import 'package:furnitrue_app/features/home/data/model/prouduct_response_model.dart';
import 'package:furnitrue_app/features/product_details/presentation/view/product_details_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 40.h),
          const AppAppBar(title: 'My Cart'),
          SizedBox(height: 36.h),

          Expanded(
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final cartCubit = context.watch<CartCubit>();
                final state = cartCubit.state;

                if (state is CartLoading) {
                  return const Center(child: AppLoadingIndicator());
                } else if (state is CartSuccessWithItems) {
                  final cartItems = state.items;

                  if (cartItems.isEmpty) {
                    return const Center(child: Text("السلة فارغة"));
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            final favoriteCubit = context.read<FavoriteCubit>();
                            final favoriteProduct = favoriteCubit
                                .findFavoriteById(item.id);

                            final actualProduct =
                                favoriteProduct ??
                                Product(
                                  id: item.id,
                                  name: item.name,
                                  price: item.price,
                                  images: [],
                                  description: '',
                                  categoryName: '',
                                );

                            return Padding(
                              padding: EdgeInsets.only(bottom: 14.h),
                              child: InkWell(
                                onTap:
                                    () => RouteUtils.push(
                                      ProductDetailsView(
                                        product: actualProduct,
                                      ),
                                    ),
                                child: MyCartContainer(
                                  key: ValueKey(item.id),
                                  image: 'assets/images/cart_placeholder.png',
                                  title: item.name,
                                  price: item.price,
                                  addProductIcon: CartCounterContainer(
                                    initialQuantity: item.quantity,
                                    cartId: item.id,
                                  ),
                                  onPressed: (context) async {
                                    await context
                                        .read<CartCubit>()
                                        .deleteCartItem(item.id);
                                  },
                                  product: actualProduct,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      BlocSelector<CartCubit, CartState, List<CartItem>>(
                        selector: (state) {
                          if (state is CartSuccessWithItems) return state.items;
                          return [];
                        },
                        builder: (context, cartItems) {
                          return TotalPrice(
                            totalPrice: calculateTotalPrice(cartItems),
                            totalItems:
                                cartItems
                                    .fold<int>(
                                      0,
                                      (sum, item) => sum + item.quantity,
                                    )
                                    .toString(),
                          );
                        },
                      ),

                      SizedBox(height: 20.h),

                      //  ✅ Payment Section remains unchanged
                      BlocBuilder<PaymentCubit, PaymentState>(
                        builder: (context, state) {
                          final cartCubit = context.read<CartCubit>();
                          final paymentCubit = context.read<PaymentCubit>();

                          return AppButton(
                            btnText:
                                state is PaymentLoading
                                    ? 'Loading...'
                                    : 'Check out',
                            width: double.infinity,
                            onTap: () async {
                              // ✅ الخطوة 1: جلب السلة الأحدث من الـ API
                              await cartCubit.getCartItems();

                              // ✅ الخطوة 2: حساب السعر الكلي بناءً على أحدث بيانات
                              final items =
                                  cartCubit.state is CartSuccessWithItems
                                      ? (cartCubit.state
                                              as CartSuccessWithItems)
                                          .items
                                      : <CartItem>[];

                              final amountCents =
                                  (double.parse(calculateTotalPrice(items)) *
                                          100)
                                      .toInt();

                              // ✅ الخطوة 3: بدء عملية الدفع
                              await paymentCubit.startPayment(amountCents);

                              if (paymentCubit.state is PaymentSuccess) {
                                final paymentKey =
                                    (paymentCubit.state as PaymentSuccess)
                                        .paymentToken;
                                final url =
                                    'https://accept.paymob.com/api/acceptance/iframes/916101?payment_token=$paymentKey';
                                launchUrl(Uri.parse(url));
                              } else if (paymentCubit.state is PaymentError) {
                                final msg =
                                    (paymentCubit.state as PaymentError).error;
                                showSnackBar(msg, isError: true);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  );
                } else if (state is CartError) {
                  return Center(child: Text(state.error));
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

String calculateTotalPrice(List<CartItem> items) {
  double total = 0;
  for (var item in items) {
    final cleanedPrice = item.price.replaceAll(RegExp(r'[^\d.]'), '');
    final double price = double.tryParse(cleanedPrice) ?? 0;
    total += price;
  }
  return total.toStringAsFixed(2);
}
