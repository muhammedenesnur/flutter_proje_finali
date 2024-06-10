import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// A custom text widget that supports localization.
final class CustomText extends StatelessWidget {
  /// Creates a custom text widget.
  ///
  /// The [text] parameter is required and specifies the text to be displayed.
  /// The [style] parameter is optional and specifies the text style.
  /// The [textAlign] parameter is optional and specifies the alignment
  /// of the text.
  const CustomText({
    required this.text,
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
    this.args,
  });

  /// The text to be displayed.
  final String text;

  /// The style of the text.
  final TextStyle? style;

  /// The alignment of the text.
  final TextAlign? textAlign;

  /// The arguments to be passed to the localization manager.
  final List<String>? args;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
    ).tr(
      args: args,
    );
  }
}
