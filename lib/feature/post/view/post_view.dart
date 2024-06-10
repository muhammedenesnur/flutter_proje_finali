import 'package:dev_template/feature/post/cubit/post_cubit.dart';
import 'package:dev_template/feature/post/cubit/post_state.dart';
import 'package:dev_template/feature/post/service/post_service.dart';
import 'package:dev_template/product/core/model/products.dart';
import 'package:dev_template/product/utils/service/dio_service_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView>
    with AutomaticKeepAliveClientMixin<PostView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<ProductsCubit>(
      create: (context) => ProductsCubit(
        ProductsService(
          DioServiceManager(),
        ),
      )..getPosts(),
      child: const _PostBody(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

final class _PostBody extends StatelessWidget {
  const _PostBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductStatus.initial:
              return const _InitialField._();
            case ProductStatus.loading:
              return const _LoadingField._();
            case ProductStatus.loaded:
              return const _PostList._();
            case ProductStatus.error:
              return const _ErrorField._();
          }
        },
      ),
    );
  }
}

final class _LoadingField extends StatelessWidget {
  const _LoadingField._();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

final class _InitialField extends StatelessWidget {
  const _InitialField._();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

final class _ErrorField extends StatelessWidget {
  const _ErrorField._();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductsCubit, ProductsState, String>(
      selector: (state) => state.error,
      builder: (context, state) {
        return Center(
          child: Text(state),
        );
      },
    );
  }
}

final class _PostList extends StatelessWidget {
  const _PostList._();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductsCubit, ProductsState, List<Products>>(
      selector: (state) => state.products,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final post = state[index];
              return Card(
                elevation: 4,
                child: ListTile(
                  title: Text(
                    post.title ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(post.category ?? ''),
                  trailing: Image.network(
                    post.image ?? '',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
