import 'package:bloc/bloc.dart';
import 'package:dev_template/feature/shoes/cubit/shoes_state.dart';
import 'package:dev_template/product/core/model/shoe.dart';
import 'package:dev_template/product/utils/service/json_service.dart';
import 'package:flutter/material.dart';

final class ShoesCubit extends Cubit<ShoesState> {
  ShoesCubit(this._jsonService) : super(const ShoesState());

  final IJsonService _jsonService;

  Future<void> getShoes() async {
    emit(state.copyWith(status: ShoesStatus.loading));
    try {
      final shoes = await _jsonService.getShoes();
      emit(state.copyWith(status: ShoesStatus.success, shoes: shoes));
    } catch (e) {
      emit(state.copyWith(status: ShoesStatus.failure, error: e.toString()));
    }
  }

  /// Save shoes
  Future<void> saveShoes(List<Shoe> shoes) async {
    emit(state.copyWith(status: ShoesStatus.loading));
    try {
      await _jsonService.saveShoes(shoes);
      emit(state.copyWith(status: ShoesStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ShoesStatus.failure, error: e.toString()));
    }
  }

  /// Load shoes from a selected JSON file
  Future<void> loadShoesFromFile() async {
    emit(state.copyWith(status: ShoesStatus.loading));
    try {
      final newShoes = await _jsonService.loadShoesFromFile();
      if (newShoes.isEmpty) {
        emit(
          state.copyWith(
            status: ShoesStatus.failure,
            error: 'No shoes found',
          ),
        );
      }
      emit(
        state.copyWith(
          status: ShoesStatus.success,
          shoes: state.shoes + newShoes,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ShoesStatus.failure, error: e.toString()));
    }
  }

  /// Export shoes to a JSON file
  Future<void> exportShoes(BuildContext context) async {
    emit(state.copyWith(status: ShoesStatus.loading));
    try {
      if (state.shoes.isEmpty) {
        emit(
          state.copyWith(
            status: ShoesStatus.failure,
            error: 'No shoes to export',
          ),
        );
        return;
      }
      await _jsonService.exportShoes(state.shoes);
      emit(state.copyWith(status: ShoesStatus.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: ShoesStatus.failure, error: e.toString()));
    }
  }
}
