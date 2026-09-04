import 'package:equatable/equatable.dart';
import 'package:store_explorer/core/managers/themes_manager/text_theme_manager/custom_text_theme.dart';
import 'package:store_explorer/core/managers/themes_manager/themes_manager.dart';

class CustomThemeData extends Equatable {
  final DynamicColors colors;
  final CustomTextTheme textTheme;

  const CustomThemeData({required this.colors, required this.textTheme});

  @override
  List<Object> get props => [colors, textTheme];

  CustomThemeData copyWith({
    DynamicColors? colors,
    CustomTextTheme? textTheme,
  }) {
    return CustomThemeData(
      colors: colors ?? this.colors,
      textTheme: textTheme ?? this.textTheme,
    );
  }
}
