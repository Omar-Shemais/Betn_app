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
import 'package:furnitrue_app/features/payment/presentation/view/payment_web_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

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
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: 14.h,
                              ), // space between items
                              child: MyCartContainer(
                                image: 'assets/images/cart_placeholder.png',
                                title: item.name,
                                price: item.price,
                                addProductIcon: CartCounterContainer(
                                  quantity: item.quantity,
                                  cartId: item.id.toInt(),
                                  msg: 'تم تحديث الكمية والسعر الإجمالي بنجاح"',
                                ),
                                onPressed: (context) {
                                  context.read<CartCubit>().deleteCartItem(
                                    state.items[index].id,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      TotalPrice(
                        totalPrice: calculateTotalPrice(cartItems),
                        totalItems:
                            cartItems
                                .fold<int>(
                                  0,
                                  (sum, item) => sum + item.quantity,
                                )
                                .toString(),
                      ),
                      SizedBox(height: 20.h),

                      BlocBuilder<PaymentCubit, PaymentState>(
                        builder: (context, state) {
                          final cubit = context.read<PaymentCubit>();

                          return AppButton(
                            btnText:
                                state is PaymentLoading
                                    ? 'Loading...'
                                    : 'Check out',
                            width: double.infinity,
                            onTap: () async {
                              final cartCubit = context.read<CartCubit>();
                              if (cartCubit.state is CartSuccessWithItems) {
                                final items =
                                    (cartCubit.state as CartSuccessWithItems)
                                        .items;

                                final amountCents =
                                    (double.parse(calculateTotalPrice(items)) *
                                            100)
                                        .toInt();

                                // print('🛒 Total Amount in Cents: $amountCents');
                                // print('🧾 Cart Items:');
                                // for (var item in items) {
                                //   print(
                                //     '- ${item.name}, Quantity: ${item.quantity}, Price: ${item.price}',
                                //   );
                                // }

                                await cubit.startPayment(amountCents);

                                if (cubit.state is PaymentSuccess) {
                                  final paymentKey =
                                      (cubit.state as PaymentSuccess)
                                          .paymentToken;
                                  final url =
                                      'https://accept.paymob.com/api/acceptance/iframes/916101?payment_token=$paymentKey';
                                  // print('🌐 WebView URL: $url');

                                  // RouteUtils.push(
                                  //   PaymentWebView(initialUrl: url),
                                  // );

                                  launchUrl(Uri.parse(url));
                                  // RouteUtils.push(
                                  //   PaymentWebView(
                                  //     initialUrl:
                                  //         'https://accept.paymob.com/api/acceptance/iframes/916101?payment_token=$paymentKey',
                                  //   ),
                                  // );
                                } else if (cubit.state is PaymentError) {
                                  final msg =
                                      (cubit.state as PaymentError).error;
                                  showSnackBar(msg, isError: true);
                                }
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
