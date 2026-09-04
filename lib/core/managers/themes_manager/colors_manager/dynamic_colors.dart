part of "package:store_explorer/core/managers/themes_manager/themes_manager.dart";

class DynamicColors {
  DynamicColors();

  Color primary = Color(0xffE9923F);
  Color primary200 = Color(0xffDC7B1F);
  Color primary500 = Color(0xffFAEEE2);
  Color primary700 = Color(0xffFFF5EB);
  Color primary900 = Color(0xffFDF5EA);
  Color background = Color(0xFFFAFBFF);
  Color secondry = Color(0xFF0476AD);
  Color red = Color(0xFFFF0000);
  Color red2 = Color(0xFFFF6565);
  Color red500 = Color(0xffFCF1F1);
  Color lightBlue = Color(0xff08428D) ;
  Color black = Color(0xFF000000);
  Color darkGrey = Color(0xFF3C3C43);
  Color darkGrey2 = Color(0xff292929);
  Color lightGrey = Color(0xffF4F4F4);
  Color lightGrey2 = Color(0xffB4B1B1);
  Color butomClose = Color(0xff767676);
  Color green = Color(0xff3C9A5C);
  Color green500 = Color(0xffF1F7F1);
  Color grey = Color(0xFF7E8389);
  Color white = Color(0xffFFFFFF);
  Color disabledColor = Color(0xFFD9DBE5);
  Color textColor2 = Color(0xff5D5D5D);
  Color divider = Color(0xffE3E3E3);
  Color divider200 = Color(0xffF9F9F9);

  void switchToLight() {
    primary = Color(0xFF263E81);
    white = Color(0xFFFFFFFF);
  }
}
