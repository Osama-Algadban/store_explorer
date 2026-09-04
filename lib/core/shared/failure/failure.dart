import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart' show Widget;

class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.title,
    this.widget,
  });

  ///The message describing the failure.
  final String message;

  ///The custom title that appear on failure screen.
  final String title;

  ///If you want to show a custom widget on failure screen.
  ///like error icon or something else.
  final Widget? widget;

  @override
  List<Object?> get props => [
    message,
    title,
    widget,
  ];
}
