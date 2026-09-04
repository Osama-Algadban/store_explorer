import 'package:flutter/material.dart';
import 'package:store_explorer/core/managers/themes_manager/text_theme_manager/custom_text_theme.dart';
import 'package:store_explorer/core/managers/themes_manager/theme_controller/custom_theme_data.dart';
import 'package:store_explorer/core/managers/themes_manager/theme_controller/theme_controller.dart';
import 'package:store_explorer/core/managers/themes_manager/themes_manager.dart';

class ThemeWrapper extends InheritedWidget {
  ThemeWrapper({
    super.key,
    required super.child,
    this.sizer,
    this.locale,
  });

  final Locale? locale;
  final double? sizer;
  late final ThemeController controller = ThemeController(
    CustomThemeData(colors: colors, textTheme: customTextTheme),
  );
  final DynamicColors colors = DynamicColors();
  late final CustomTextTheme customTextTheme = CustomTextTheme(
    sizer: sizer  ?? 1.0,
    locale: locale ?? Locale('ar'),
    colors: colors,
  );

  static ThemeWrapper of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<ThemeWrapper>(
        aspect: ThemeWrapper,
      )
      as ThemeWrapper);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      this != oldWidget;
}
