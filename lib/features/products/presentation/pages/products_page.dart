import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_explorer/core/managers/service_locator/service_locator.dart';
import 'package:store_explorer/core/shared/extensions/context_extension.dart';
import 'package:store_explorer/core/shared/widgets/main_loader.dart';
import 'package:store_explorer/core/shared/widgets/no_search_result.dart';
import 'package:store_explorer/core/shared/widgets/search_text_field.dart';
import 'package:store_explorer/features/products/presentation/manager/products_bloc.dart';
import 'package:store_explorer/features/products/presentation/widgets/product_card.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  final Set<int> _favoriteProductIds = {};
  bool _isSearchMode = false;
  String? search;

  late final ProductsBloc _productsBloc;

  @override
  void initState() {
    super.initState();
    _productsBloc = getIt<ProductsBloc>()
      ..add(const ProductsEvent.getAndSearchProducts());

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      final state = _productsBloc.state;
      if (state.hasMore &&
          !state.isPaginationLoading &&
          !state.productsLoading) {
        _productsBloc.add(
          ProductsEvent.getAndSearchProducts(searchQuery: search),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    _productsBloc.close();
    super.dispose();
  }

  bool get _isFilteringOrSearching => _isSearchMode;

  void _onSearchChanged(String query) {
    search = query;
    if (query.isEmpty) {
      search = null;
    }
    _debounce?.cancel();
    _productsBloc.add(
      ProductsEvent.getAndSearchProducts(searchQuery: search),
    );
  }

  Future<void> _onRefresh() async {
    _productsBloc.add(
      ProductsEvent.getAndSearchProducts(isReset: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productsBloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: context.colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                            color: context.colors.black,
                          ),
                        ),
                        const Spacer(flex: 2),
                        Text(
                          "المنتجات",
                          style: context.customTextTheme.bodyLarge(),
                        ),
                        const Spacer(flex: 3),
                      ],
                    ),
                    Divider(
                      color: context.colors.divider,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: SearchTextField(
                  focusNode: _searchFocusNode,
                  onSearch: _onSearchChanged,
                  hintText: "البحث عن المنتجات...",
                ),
              ),
              Expanded(
                child: BlocConsumer<ProductsBloc, ProductsState>(
                  listener: (context, state) {
                    if (state.failure != null) {
                      context.showErrorDialog(failure: state.failure!);
                    }
                  },
                  builder: (context, state) {
                    if (state.productsLoading && state.products.isEmpty) {
                      return const Center(child: MainLoader());
                    }

                    final products = state.products;

                    if (products.isEmpty && !state.productsLoading) {
                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: 1.2 * MediaQuery.of(context).size.height,
                            child: Center(
                              child: _isFilteringOrSearching
                                  ? NoSearchResult()
                                  : const Center(
                                child: Text("لا توجد منتجات"),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: state.isPaginationLoading
                                ? MediaQuery.of(context).size.height * 0.6
                                : MediaQuery.of(context).size.height * 0.8,
                            child: RefreshIndicator(
                              onRefresh: _onRefresh,
                              child: GridView.builder(
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 1.3,
                                ),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  final isFav = _favoriteProductIds.contains(
                                    product.id,
                                  );

                                  return ProductCard(
                                    product: product,
                                    isFavorite: isFav,
                                    onFavoriteTap: () {
                                      setState(() {
                                        if (isFav) {
                                          _favoriteProductIds.remove(
                                            product.id,
                                          );
                                        } else {
                                          _favoriteProductIds.add(product.id);
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          if (state.isPaginationLoading)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: MainLoader(),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}