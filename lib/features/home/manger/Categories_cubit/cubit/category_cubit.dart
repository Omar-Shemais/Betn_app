import 'package:bloc/bloc.dart';
import 'package:furnitrue_app/features/home/data/category_repo.dart';
import 'package:furnitrue_app/features/home/manger/Categories_cubit/cubit/category_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final HomeRepo homeRepo;

  CategoriesCubit(this.homeRepo) : super(CategoriesInitial());

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      final categoriesModel = await homeRepo.getCategories();
      emit(CategoriesSuccess(categoriesModel: categoriesModel));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  void selectCategory(int index) {
    if (state is CategoriesSuccess) {
      final current = state as CategoriesSuccess;
      emit(current.copyWith(selectedIndex: index));
    }
  }
}
