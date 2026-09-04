import 'dart:math';
import 'package:flutter/material.dart';
import 'package:store_explorer/core/managers/themes_manager/text_theme_manager/custom_text_theme.dart';
import 'package:store_explorer/core/managers/themes_manager/theme_controller/theme_controller.dart';
import 'package:store_explorer/core/managers/themes_manager/theme_controller/theme_wrapper.dart';
import 'package:store_explorer/core/managers/themes_manager/themes_manager.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';
import 'package:toastification/toastification.dart';

extension ContextExtension on BuildContext {
  DynamicColors get colors => ThemeWrapper.of(this).colors;

  ThemeController get themeController => ThemeWrapper.of(this).controller;

  CustomTextTheme get customTextTheme => ThemeWrapper.of(this).customTextTheme;


  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

  ToastificationItem showErrorDialog({required Failure failure}) =>
      toastification.show(
        context: this,
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        autoCloseDuration: Duration(seconds: min(failure.message.length, 6)),
        title: Text(
          failure.title,
          style: customTextTheme.bodyRegular().copyWith(
            color: colors.black,
          ),
        ),
        description: Text(
          failure.message,
          style: customTextTheme.bodySmall().copyWith(color: colors.grey),
        ),
        alignment: Alignment.bottomCenter,
        animationDuration: const Duration(milliseconds: 300),
        showIcon: true,
        primaryColor: colors.red,
        borderSide: BorderSide(color: colors.red),
        backgroundColor: colors.red500,
        foregroundColor: Colors.transparent,
        showProgressBar: true,
        pauseOnHover: true,
        dragToClose: true,
        applyBlurEffect: false,
      );

  ToastificationItem showWarningDialog({required Failure failure}) =>
      toastification.show(
        context: this,
        type: ToastificationType.warning,
        style: ToastificationStyle.flat,
        autoCloseDuration: Duration(seconds: min(failure.message.length, 6)),
        title: Text(
          failure.title,
          style: customTextTheme.bodyRegular().copyWith(color: colors.black),
        ),
        description: Text(
          failure.message,
          style: customTextTheme.bodySmall().copyWith(color: colors.grey),
        ),
        alignment: Alignment.topCenter,
        animationDuration: const Duration(milliseconds: 300),
        icon: const Icon(Icons.close, color: warningColor),
        showIcon: true,
        primaryColor: colors.primary,
        borderSide: BorderSide(color: colors.primary),
        backgroundColor: colors.primary900,
        foregroundColor: Colors.transparent,
        showProgressBar: true,
        pauseOnHover: true,
        dragToClose: true,
        applyBlurEffect: false,
      );

  ToastificationItem showSuccessDialog({
    required String message,
    required String title,
  }) => toastification.show(
    context: this,
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: Duration(seconds: min(message.length, 6)),
    title: Text(
      title,
      style: customTextTheme.bodyRegular().copyWith(color: colors.black),
    ),
    description: Text(
      message,
      style: customTextTheme.bodySmall().copyWith(color: colors.grey),
    ),
    alignment: Alignment.bottomCenter,
    animationDuration: const Duration(milliseconds: 300),
    icon: Icon(Icons.close, color: colors.green),
    showIcon: true,
    primaryColor: colors.green,
    borderSide: BorderSide(color: colors.green),
    backgroundColor: colors.green500,
    foregroundColor: Colors.transparent,
    showProgressBar: true,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: false,
  );
}
