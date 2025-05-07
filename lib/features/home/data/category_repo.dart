import 'package:dio/dio.dart';
import 'package:furnitrue_app/core/utils/network_utils/network_utils.dart';
import 'package:furnitrue_app/features/home/data/model/categories_response_model.dart';
import 'package:furnitrue_app/features/home/data/model/prouduct_response_model.dart';

class HomeRepo {
  Future<CategoriesModel> getCategories() async {
    try {
      final response = await NetworkUtils.get("categories/get_categories.php");
      if (response.statusCode == 200) {
        final data = response.data;
        return CategoriesModel.fromJson(data);
      } else {
        throw Exception("Failed to load categories");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}

class ProductRepo {
  Future<ProductResponseModel> getProducts() async {
    final response = await NetworkUtils.get("products/get_products.php");

    if (response.statusCode == 200) {
      return ProductResponseModel.fromJson(response.data);
    } else {
      throw Exception("Failed to load products");
    }
  }
}
