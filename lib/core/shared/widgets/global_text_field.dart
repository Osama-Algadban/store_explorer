import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_explorer/core/shared/extensions/context_extension.dart';

class GlobalTextField extends StatelessWidget {
  const GlobalTextField({
    super.key,
    this.width,
    this.height,
    this.onChanged,
    this.hintText,
    this.hintStyle,
    this.controller,
    this.validation,
    this.textStyle,
    this.label,
    this.labelStyle,
    this.initialValue,
    this.inputType,
    this.obscure = false,
    this.enabled = true,
    this.suffixIcon,
    this.focusNode,
    this.errorMaxLines,
    this.showRequiredAtLabel = false,
    this.readOnly = false,
    this.onTap,
    this.filled = false,
    this.fillColor,
    this.borderColor,
    this.hasError = false,
    this.formatters,
    this.validationMood,
    this.minLines = 1,
    this.maxLines = 1,
    this.prefixIcon,
  });

  final bool readOnly;
  final double? width;
  final double? height;
  final void Function(String)? onChanged;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final TextStyle? textStyle;
  final String? label;
  final TextStyle? labelStyle;
  final String? initialValue;
  final TextInputType? inputType;
  final bool obscure;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final int? errorMaxLines;
  final bool showRequiredAtLabel;
  final VoidCallback? onTap;
  final bool filled;
  final Color? fillColor;
  final Color? borderColor;
  final bool hasError;
  final List<TextInputFormatter>? formatters;
  final AutovalidateMode? validationMood;
  final int minLines;
  final int maxLines;
  final bool enabled;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final activeBorderColor = hasError
        ? context.colors.red
        : (borderColor ?? context.colors.disabledColor);

    final borderSide = BorderSide(
      color: activeBorderColor,
      width: hasError || borderColor != null ? 1.5 : 1.0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${label ?? ""} ",
                    style: labelStyle ??
                        context.customTextTheme.bodyRegular().copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.colors.darkGrey,
                        ),
                  ),
                  if (showRequiredAtLabel)
                    TextSpan(
                      text: "*",
                      style: (labelStyle ?? context.customTextTheme.bodyRegular())
                          .copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
        SizedBox(
          width: width,
          height: height,
          child: TextFormField(
            enabled: enabled,
            minLines: minLines,
            maxLines: maxLines,
            autovalidateMode: validationMood,
            inputFormatters: formatters,
            readOnly: readOnly,
            onTap: onTap,
            focusNode: focusNode,
            controller: controller,
            obscureText: obscure,
            initialValue: initialValue,
            validator: validation,
            onChanged: onChanged,
            style: textStyle ??
                context.customTextTheme.bodyRegular().copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.colors.textColor2,
                ),
            keyboardType: inputType,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              filled: filled,
              fillColor: hasError
                  ? context.colors.red.withValues(alpha: 0.05)
                  : fillColor,
              errorMaxLines: errorMaxLines,
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: hintStyle ??
                  context.customTextTheme.bodySmall().copyWith(
                    color: context.colors.lightGrey2,
                  ),
              border: OutlineInputBorder(
                borderRadius:  BorderRadius.circular(10),
                borderSide: borderSide,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:  BorderRadius.circular(10),
                borderSide: borderSide,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius:  BorderRadius.circular(10),
                borderSide: BorderSide(color: context.colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:  BorderRadius.circular(10),
                borderSide: hasError
                    ? BorderSide(color: context.colors.red, width: 2)
                    : BorderSide(color: context.colors.primary),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius:  BorderRadius.circular(10),
                borderSide: BorderSide(color: context.colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:  BorderRadius.circular(10),
                borderSide: borderSide,
              ),
            ),
          ),
        ),
      ],
    );
  }
}