import 'package:flutter/material.dart';
import 'package:store_explorer/core/managers/assets_managers/fonts.gen.dart';
import 'package:store_explorer/core/managers/themes_manager/text_theme_manager/custom_text_theme.dart';

part 'colors_manager/colors_manager.dart';

part 'colors_manager/dynamic_colors.dart';

class ThemesManager {
  static ThemeData themeData(
      CustomTextTheme customTheme,
      DynamicColors colors,
      ) {
    return ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: colors.primary),
      scaffoldBackgroundColor: colors.white,
      dividerColor: colors.divider,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.background,
        primary: colors.primary,
        secondary: colors.secondry,
        error: colors.red,
        surface: colors.background,
        onSurface: colors.primary,
        outline: colors.grey,
      ),
      fontFamily: FontFamily.roboto,
      textTheme: getTextTheme(customTheme, colors),
      dialogTheme: DialogThemeData(backgroundColor: colors.background),
    );
  }

  static TextTheme getTextTheme(
      CustomTextTheme customTheme,
      DynamicColors colors,
      ) => TextTheme(
    bodyMedium: customTheme.bodyRegular(),
    bodySmall: customTheme.bodySmall(),
    bodyLarge: customTheme.bodyLarge(),
    titleSmall: customTheme.smallTitle(),
    titleMedium: customTheme.mediumTitle(),
    titleLarge: customTheme.largeTitle(),
    headlineLarge: customTheme.largeTitle(),
  );
}
