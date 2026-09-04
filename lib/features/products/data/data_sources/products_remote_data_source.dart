import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/managers/api_manager/api_manager.dart';
import 'package:store_explorer/core/managers/managers.dart';
import 'package:store_explorer/features/products/data/model/products_pagination_model.dart';
import 'package:store_explorer/features/products/domain/params/products_params.dart';

abstract class ProductsRemoteDataSource {
  Future<ProductsPaginationModel> getProducts(ProductsParams params);
  Future<ProductsPaginationModel> getProductsWithSearch(ProductsParams params) ;
}

@LazySingleton(as: ProductsRemoteDataSource)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  static final String _productsUrl = ApiRoutes.products;
  static final String _searchProductsUrl = ApiRoutes.productWithSearch;

  @override
  Future<ProductsPaginationModel> getProducts(ProductsParams params) async {

    final Map<String, String> queryParameters = params.toJson().map(
          (key, value) => MapEntry(key, value.toString()),
        );
    queryParameters.removeWhere((key, value) => value.isEmpty);

    final String fullUrl = Uri.parse(_productsUrl)
        .replace(queryParameters: queryParameters)
        .toString();

    final request = ApiRequest(
      requestType: RequestType.get,
      url: fullUrl,
      autoConvert: false,
    );

    final response = await Managers.apiManager.request(request);

    return ProductsPaginationModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ProductsPaginationModel> getProductsWithSearch(ProductsParams params) async {

    final Map<String, String> queryParameters = params.toJson().map(
          (key, value) => MapEntry(key, value.toString()),
        );
    queryParameters.removeWhere((key, value) => value.isEmpty);

    final String fullUrl = Uri.parse(_searchProductsUrl)
        .replace(queryParameters: queryParameters)
        .toString();


    final request = ApiRequest(
      requestType: RequestType.get,
      url: fullUrl,
      autoConvert: false,
    );

    final response = await Managers.apiManager.request(request);

    return ProductsPaginationModel.fromJson(response.data as Map<String, dynamic>);
  }
}
