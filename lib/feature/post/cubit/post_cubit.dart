import 'package:dev_template/feature/post/cubit/post_state.dart';
import 'package:dev_template/feature/post/service/post_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._postService)
      : super(const ProductsState(status: ProductStatus.initial));

  final ProductsService _postService;

  Future<void> getPosts() async {
    emit(state.copyWith(status: ProductStatus.loading));
    final response = await _postService.getProducts();
    if (response.data != null) {
      emit(state.copyWith(
          status: ProductStatus.loaded, products: response.data));
    } else {
      emit(state.copyWith(status: ProductStatus.error, error: response.error));
    }
  }
}
