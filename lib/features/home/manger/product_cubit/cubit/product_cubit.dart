import 'package:bloc/bloc.dart';
import 'package:furnitrue_app/features/home/data/category_repo.dart';
import 'package:furnitrue_app/features/home/manger/product_cubit/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo repo;

  ProductCubit(this.repo) : super(ProductInitial());

  Future<void> getProducts() async {
    emit(ProductLoading());
    try {
      final response = await repo.getProducts();
      emit(ProductLoaded(response.products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void filterByCategory(String categoryName) async {
    try {
      final response = await repo.getProducts();
      final filtered =
          response.products
              .where((product) => product.categoryName == categoryName)
              .toList();
      emit(ProductLoaded(filtered));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
