import 'dart:async';
import 'package:flutter/material.dart';
import 'package:store_explorer/core/shared/extensions/context_extension.dart';
import 'package:store_explorer/core/shared/widgets/global_text_field.dart';

class SearchTextField extends StatefulWidget {
  final String? hintText ;
  final Function(String) onSearch;
  final FocusNode? focusNode;

  const SearchTextField({super.key,  required this.onSearch, this.hintText, this.focusNode});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalTextField(
      focusNode: widget.focusNode,

      height: 40,
      hintText: widget.hintText,
      hintStyle: context.customTextTheme.bodySmall().copyWith(
        color: context.colors.black.withValues(alpha: 0.6),
        fontSize: 15
      ),
      filled: true,
      fillColor: context.colors.lightGrey ,
      onChanged: _onSearchChanged,
      prefixIcon:IconButton(
        icon: Icon(Icons.search,color: context.colors.black,),
        onPressed: () {
        },
      ),
    );
  }
}