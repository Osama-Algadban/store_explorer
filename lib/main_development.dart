import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_explorer/app.dart';
import 'package:store_explorer/core/managers/managers.dart';
import 'package:store_explorer/core/managers/service_locator/service_locator.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await configureDependencies();

 await Managers.init();

  enterFullscreenImmersiveSticky();

  runApp(App.instance);
}

void enterFullscreenImmersiveSticky() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}