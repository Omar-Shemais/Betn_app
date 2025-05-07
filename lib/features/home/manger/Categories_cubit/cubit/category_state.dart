import 'package:furnitrue_app/features/home/data/model/categories_response_model.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final CategoriesModel categoriesModel;
  final int selectedIndex;

  CategoriesSuccess({required this.categoriesModel, this.selectedIndex = 0});

  CategoriesSuccess copyWith({
    CategoriesModel? categoriesModel,
    int? selectedIndex,
  }) {
    return CategoriesSuccess(
      categoriesModel: categoriesModel ?? this.categoriesModel,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

class CategoriesError extends CategoriesState {
  final String error;

  CategoriesError(this.error);
}
