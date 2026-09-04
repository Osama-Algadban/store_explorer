import 'package:flutter/material.dart';
import 'package:store_explorer/core/shared/extensions/context_extension.dart';

class NoSearchResult extends StatelessWidget {
  const NoSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          "No Search Results" ,
          style: context.customTextTheme.bodyLarge(),
        ),
      ],
    );
  }
}
