import 'package:flutter/material.dart';
import 'package:store_explorer/core/shared/extensions/context_extension.dart';

class MainLoader extends StatelessWidget {
  const MainLoader({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: color ?? context.colors.primary);
  }
}
