import 'package:store_explorer/core/managers/assets_managers/fonts.gen.dart';
import 'package:store_explorer/core/managers/themes_manager/themes_manager.dart';
import 'package:flutter/material.dart';

import 'font_size.dart';

class CustomTextTheme {
  CustomTextTheme({
    required this.sizer,
    required this.locale,
    required this.colors,
  });

  final double sizer;
  final Locale locale;
  final DynamicColors colors;

  TextStyle largeTitle() => TextStyle(
    fontFamily: FontFamily.roboto,
    fontWeight: FontWeight.w600,
    fontSize: FontSize.largeTitle,
    color: colors.black,
  );

  TextStyle mediumTitle() => TextStyle(
    fontFamily: FontFamily.roboto,
    fontWeight: FontWeight.w500,
    fontSize: FontSize.mediumTitle,
    color: colors.black,
  );

  TextStyle smallTitle() => TextStyle(
    color: colors.black,
    fontFamily: FontFamily.roboto,
    fontWeight: FontWeight.w600,
    fontSize: FontSize.smallTitle,
  );

  TextStyle bodyRegular() => TextStyle(
    color: colors.black,
    fontFamily: FontFamily.roboto,
    fontWeight: FontWeight.w600,
    fontSize: FontSize.body,
  );

  TextStyle bodyLarge() => TextStyle(
    fontFamily: FontFamily.roboto,
    fontWeight: FontWeight.w600,
    fontSize: FontSize.bodyLarge,
    color: colors.black,
  );

  TextStyle bodySmall() => TextStyle(
    fontFamily: FontFamily.roboto,
    fontWeight: FontWeight.w600,
    fontSize: FontSize.bodySmall,
    color: colors.black,
  );
}
