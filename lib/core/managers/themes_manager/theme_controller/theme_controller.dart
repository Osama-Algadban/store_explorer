import 'package:flutter/material.dart';
import 'package:store_explorer/core/managers/themes_manager/theme_controller/custom_theme_data.dart';
import 'package:store_explorer/core/managers/themes_manager/themes_manager.dart';

class ThemeController extends ValueNotifier<CustomThemeData> {
  ThemeController(super.value);

  void switchToLight() {
    value = value.copyWith(colors: DynamicColors()..switchToLight());
    notifyListeners();
  }
}
