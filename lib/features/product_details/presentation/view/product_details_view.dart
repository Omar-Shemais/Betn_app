import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnitrue_app/features/cart/data/repo/cart_repo.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';
import 'package:furnitrue_app/features/home/data/model/prouduct_response_model.dart';
import 'package:furnitrue_app/features/product_details/presentation/view/widgets/product_details_view_body.dart';

class ProductDetailsView extends StatelessWidget {
  final Product product;
  const ProductDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CartCubit(CartRepo()),
        child: ProductDetailsViewBody(product: product),
      ),
    );
  }
}
