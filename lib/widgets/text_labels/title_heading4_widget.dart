import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/custom_style.dart';

class TitleHeading4Widget extends StatelessWidget {
  const TitleHeading4Widget({
    super.key,
    required this.text,
    this.textAlign,
    this.textOverflow,
    this.padding = paddingValue,
    this.opacity = 1.0,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final EdgeInsetsGeometry padding;
  final double opacity;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  static const paddingValue = EdgeInsets.all(0.0);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Opacity(
          opacity: opacity,
          child: Padding(
            padding: padding,
            child: Text(
              DynamicLanguage.isLoading ? "" : DynamicLanguage.key(text),
              style: Get.isDarkMode
                  ? CustomStyle.darkHeading4TextStyle.copyWith(
                      fontSize: fontSize, fontWeight: fontWeight, color: color)
                  : CustomStyle.lightHeading4TextStyle.copyWith(
                      fontSize: fontSize, fontWeight: fontWeight, color: color),
              textAlign: textAlign,
              overflow: textOverflow,
              maxLines: maxLines,
            ),
          ),
        ));
  }
}
