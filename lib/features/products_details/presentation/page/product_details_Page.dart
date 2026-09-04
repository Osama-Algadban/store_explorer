import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_explorer/core/managers/bloc_favorite/favorite_bloc.dart';
import 'package:store_explorer/core/managers/service_locator/service_locator.dart';
import 'package:store_explorer/core/shared/extensions/context_extension.dart';
import 'package:store_explorer/core/shared/widgets/favorite_button.dart';
import 'package:store_explorer/core/shared/widgets/main_loader.dart';
import 'package:store_explorer/features/products/domain/entity/products_entity.dart';
import 'package:store_explorer/features/products_details/presentation/helper/price_utils.dart';
import 'package:store_explorer/features/products_details/presentation/manager/products_details_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;
  final ProductsEntity? product;

  const ProductDetailsPage({
    super.key,
    required this.productId,
    this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _currentImageIndex = 0;
  late final ProductsDetailsBloc _productsDetailsBloc;
  late final FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    super.initState();
    _favoriteBloc = getIt<FavoriteBloc>();
    _productsDetailsBloc = getIt<ProductsDetailsBloc>()
      ..add(ProductsDetailsEvent.getProductsDetails(widget.productId));
  }

  @override
  void dispose() {
    _productsDetailsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _favoriteBloc),
        BlocProvider.value(value: _productsDetailsBloc),
      ],
      child: BlocConsumer<ProductsDetailsBloc, ProductsDetailsState>(
        listener: (context, state) {
          if (state.failure != null) {
            context.showErrorDialog(failure: state.failure!);
          }
        },
        builder: (context, state) {
          if (state.productsDetailsLoading && state.productDetails == null) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: MainLoader(),
              ),
            );
          }

          if (state.productDetails == null) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
                    const SizedBox(height: 16),
                    Text(
                      state.failure?.message ?? "حدث خطأ أثناء تحميل تفاصيل المنتج",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _productsDetailsBloc.add(
                          ProductsDetailsEvent.getProductsDetails(widget.productId),
                        );
                      },
                      child: const Text("إعادة المحاولة"),
                    ),
                  ],
                ),
              ),
            );
          }

          final product = state.productDetails!;
          final double finalPrice = PriceUtils.calculatePriceAfterDiscount(
            product.price,
            product.discountPercentage,
          );

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 350,
                        child: PageView.builder(
                          itemCount: product.images.isEmpty ? 1 : product.images.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            if (product.images.isEmpty) {
                              return (product.thumbnail != null && product.thumbnail!.isNotEmpty)
                                  ? Image.network(
                                      product.thumbnail!,
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                      errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                                    )
                                  : const Icon(Icons.image_not_supported, size: 64, color: Colors.grey);
                            }
                            return Image.network(
                              product.images[index],
                              fit: BoxFit.contain,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      // زر الرجوع
                      Positioned(
                        top: 50,
                        left: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withValues(alpha: 0.8),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        right: 20,
                        child: FavoriteToggle(productId: product.id.toString()),
                      ),
                      // مؤشر الصفحات (Dots)
                      if (product.images.length > 1)
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              product.images.length,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentImageIndex == index ? 12 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentImageIndex == index
                                      ? Colors.blueAccent
                                      : Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // 2. تفاصيل المنتج
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // البراند والتصنيف
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.brand ?? '',
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              product.category,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // العنوان
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // التقييم وحالة المخزون
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 18),
                                  const SizedBox(width: 4),
                                  Text(
                                    product.rating.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Icon(
                              product.stock > 0 ? Icons.check_circle : Icons.error,
                              color: product.stock > 0 ? Colors.green : Colors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product.availabilityStatus ??
                                  (product.stock > 0
                                      ? "In Stock (${product.stock})"
                                      : "Out of Stock"),
                              style: TextStyle(
                                color: product.stock > 0 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // السعر
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${finalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (product.discountPercentage > 0) ...[
                              Text(
                                "\$${product.price}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${product.discountPercentage}% OFF",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 20),

                        // الوصف
                        const Text(
                          "Description",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // زر أضف للسلة
            bottomSheet: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}