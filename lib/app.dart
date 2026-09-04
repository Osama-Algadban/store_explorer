import 'package:flutter/material.dart';
import 'package:store_explorer/core/managers/themes_manager/theme_controller/theme_wrapper.dart';
import 'package:store_explorer/core/managers/themes_manager/themes_manager.dart';
import 'package:store_explorer/core/shared/extensions/context_extension.dart';
import 'package:store_explorer/features/main_router_page/MainRouterPage.dart';

class App extends StatelessWidget {
  const App._internal();

  static App instance = App._internal();

  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (translationContext) {
        const fixedLocale = Locale('ar');
        
        return ThemeWrapper(
          locale: fixedLocale,
          child: Builder(
            builder: (ctx) => ValueListenableBuilder(
              valueListenable: ctx.themeController,
              builder: (context, value, _) {
                return MaterialApp(
                  locale: fixedLocale,
                  debugShowCheckedModeBanner: false,
                  title: 'Tamkeen',
                  theme: ThemesManager.themeData(
                    value.textTheme,
                    value.colors,
                  ),
                  builder: (context, child) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: child!,
                    );
                  },
                  home: MainRouterPage()
                );
              },
            ),
          ),
        );
      },
    );
  }
}