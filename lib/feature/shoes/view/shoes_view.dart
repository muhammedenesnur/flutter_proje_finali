import 'package:dev_template/feature/shoes/cubit/shoes_cubit.dart';
import 'package:dev_template/feature/shoes/cubit/shoes_state.dart';
import 'package:dev_template/product/core/model/shoe.dart';
import 'package:dev_template/product/utils/service/json_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ShoesView extends StatelessWidget {
  const ShoesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShoesCubit>(
      create: (context) => ShoesCubit(
        JsonService(),
      )..getShoes(),
      child: const _ShoesBody(),
    );
  }
}

final class _ShoesBody extends StatelessWidget {
  const _ShoesBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'add',
        onPressed: () {
          context.read<ShoesCubit>().loadShoesFromFile();
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ShoesCubit, ShoesState>(
        builder: (context, state) {
          switch (state.status) {
            case ShoesStatus.loading:
              return const _LoadingField();
            case ShoesStatus.success:
              return const _ShoesListField._();
            case ShoesStatus.failure:
              return const _ErrorField._();
            case ShoesStatus.initial:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

final class _ErrorField extends StatelessWidget {
  const _ErrorField._();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ShoesCubit, ShoesState, String>(
      selector: (state) => state.error!,
      builder: (context, state) {
        return Center(
          child: Text(state),
        );
      },
    );
  }
}

final class _LoadingField extends StatelessWidget {
  const _LoadingField();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

final class _ShoesListField extends StatelessWidget {
  const _ShoesListField._();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ShoesCubit, ShoesState, List<Shoe>>(
      selector: (state) => state.shoes,
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            final shoe = state[index];
            return ListTile(
              title: Text(shoe.brand.toString()),
              trailing: Text('${shoe.price} \$'),
              subtitle: Text('${shoe.size}'),
            );
          },
        );
      },
    );
  }
}
