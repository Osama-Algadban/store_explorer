import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:store_explorer/core/managers/service_locator/service_locator.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(initializerName: 'init')
Future<void> configureDependencies() async {
  getIt.init();
}
