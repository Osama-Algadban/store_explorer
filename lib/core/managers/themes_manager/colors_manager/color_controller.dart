import 'package:flutter/material.dart';
import 'package:store_explorer/core/managers/themes_manager/themes_manager.dart';

class ColorController extends ValueNotifier<DynamicColors> {
  ColorController() : super(DynamicColors());

  void switchToLight() {
    value.switchToLight();
    notifyListeners();
  }
}
