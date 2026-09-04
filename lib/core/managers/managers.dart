import 'package:store_explorer/core/managers/api_manager/api_manager.dart';
import 'package:store_explorer/core/managers/service_locator/service_locator.dart';

class Managers {
  static ApiManager apiManager = getIt<ApiManager>();


  static init() {
    apiManager.config();
  }
}
