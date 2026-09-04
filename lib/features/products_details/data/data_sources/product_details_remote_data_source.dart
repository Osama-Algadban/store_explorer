import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/managers/api_manager/api_manager.dart';
import 'package:store_explorer/core/managers/managers.dart';
import 'package:store_explorer/features/products_details/data/model/product_details_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductDetailsModel> getProductDetails(int id);
}

@LazySingleton(as: ProductDetailsRemoteDataSource)
class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  @override
  Future<ProductDetailsModel> getProductDetails(int id) async {
    final request = ApiRequest(
      requestType: RequestType.get,
      url: ApiRoutes.product(id),
      autoConvert: false,
    );

    final response = await Managers.apiManager.request(request);

    return ProductDetailsModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
