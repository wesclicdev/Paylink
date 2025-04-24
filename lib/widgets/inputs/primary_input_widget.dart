import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/basic_screen_imports.dart';
import '../others/custom_image_widget.dart';

enum BSS {
  enabledBorder,
  b,
  disableBorder,
  focusedBorder,
  errorBorder,
  focusedErrorBorder
}

enum BorderStyle {
  outline,
  underline,
  none,
}

class PrimaryInputWidget extends StatefulWidget {
  final String hintText, label, phoneCode;
  final String? optionalLabel;
  final String? prefixIconPath;
  final int maxLines;
  final bool isValidator;
  final bool isPasswordField;
  final bool autoFocus;
  final bool readOnly;
  final bool isFilled;
  final bool showBorderSide;
  final bool validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? padding;
  final double? radius;
  final double borderWidth;
  final Color? fillColor;
  final Color? shadowColor;
  final Decoration? customShapeDecoration;
  final EdgeInsetsGeometry? customPadding;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final AlignmentGeometry? alignment;
  final BorderStyle borderStyle;

  const PrimaryInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIconPath = "",
    this.phoneCode = "",
    this.isValidator = true,
    this.isPasswordField = false,
    this.isFilled = true,
    this.validator = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.borderWidth = 2,
    this.radius,
    this.customPadding,
    this.padding,
    required this.label,
    this.textInputType,
    this.inputFormatters,
    this.alignment,
    this.shadowColor,
    this.borderStyle = BorderStyle.outline,
    this.fillColor,
    this.showBorderSide = false,
    this.customShapeDecoration,
    this.optionalLabel,
  });

  @override
  State<PrimaryInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<PrimaryInputWidget> {
  FocusNode? focusNode;
  bool isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(context),
          )
        : _buildTextFormFieldWidget(context);
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: DynamicLanguage.key(widget.hintText),
      hintStyle: CustomStyle.lightHeading3TextStyle.copyWith(
        fontSize: Dimensions.headingTextSize3,
        fontWeight: FontWeight.w600,
        color: CustomColor.primaryLightTextColor.withOpacity(0.20),
      ),
      border: _setBorderStyle(BSS.b),
      enabledBorder: _setBorderStyle(BSS.enabledBorder),
      focusedBorder: _setBorderStyle(BSS.focusedBorder),
      disabledBorder: _setBorderStyle(BSS.disableBorder),
      errorBorder: _setBorderStyle(BSS.errorBorder),
      focusedErrorBorder: _setBorderStyle(BSS.focusedErrorBorder),
      prefixIcon: _setPrefixIcon(),
      // prefixIconConstraints: prefixConstraints,
      // suffixIconConstraints: suffixConstraints,
      suffixIcon: _setSuffixIcon(),
      fillColor: _setFillColor(context),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  // _buildOnFieldSubmitted() {}

  // _buildOnTap() {}

  _buildTextFormFieldWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        Container(
          decoration: _buildShapeDecoration(context),
          margin: EdgeInsets.zero,
          child: TextFormField(
            readOnly: widget.readOnly,
            controller: widget.controller,
            focusNode: focusNode,
            autofocus: widget.autoFocus,
            style: _setFontStyle(),
            textAlign: TextAlign.left,
            inputFormatters: widget.inputFormatters,
            obscureText: widget.isPasswordField ? isVisibility : false,
            textInputAction: TextInputAction.next,
            keyboardType: widget.textInputType,
            maxLines: widget.maxLines,
            decoration: _buildDecoration(),
            validator: _setValidator(),
            cursorColor: Theme.of(context).primaryColor,
            onTap: () {
              setState(() {
                focusNode!.requestFocus();
              });
            },
            onTapAlwaysCalled: true,
            onFieldSubmitted: (value) {
              setState(() {
                focusNode!.unfocus();
              });
            },
            onEditingComplete: () {
              setState(() {
                focusNode!.unfocus();
              });
            },
            onTapOutside: (value) {
              setState(() {
                focusNode!.unfocus();
              });
            },
            onSaved: (value) {
              setState(() {
                focusNode!.unfocus();
              });
            },
          ),
        ),
      ],
    );
  }

  _buildTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              DynamicLanguage.key(widget.label),
              style: CustomStyle.lightHeading4TextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.headingTextSize3,
                color: CustomColor.primaryLightTextColor,
              ),
            ),
            Text(
              DynamicLanguage.key(widget.optionalLabel ?? ""),
              style: CustomStyle.lightHeading4TextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.headingTextSize4,
                color: CustomColor.primaryLightColor.withOpacity(.8),
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
      ],
    );
  }

  _setBorderSide(borderSideStyle) {
    switch (borderSideStyle) {
      case BSS.enabledBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.primaryLightTextColor.withOpacity(0.2),
        );
      case BSS.b:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.primaryLightTextColor.withOpacity(0.2),
        );
      case BSS.disableBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.primaryLightTextColor.withOpacity(0.2),
        );
      case BSS.focusedBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: Theme.of(context).primaryColor,
        );
      case BSS.errorBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: Colors.red,
        );
      case BSS.focusedErrorBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: Colors.transparent,
        );
      default:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.primaryLightTextColor.withOpacity(0.2),
        );
    }
  }

  _setBorderStyle(borderSideStyle) {
    switch (widget.borderStyle) {
      case BorderStyle.outline:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: widget.showBorderSide
              ? _setBorderSide(borderSideStyle)
              : BorderSide.none,
        );
      case BorderStyle.underline:
        return UnderlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: widget.showBorderSide
              ? _setBorderSide(borderSideStyle)
              : BorderSide.none,
        );
      case BorderStyle.none:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: widget.showBorderSide
              ? _setBorderSide(borderSideStyle)
              : BorderSide.none,
        );
    }
  }

  _setFillColor(BuildContext context) {
    return widget.fillColor ?? Theme.of(context).primaryColor;
  }

  _setFilled() {
    return widget.isFilled;
  }

  _setFontStyle() {
    return CustomStyle.darkHeading3TextStyle.copyWith(
      color: focusNode!.hasFocus
          ? Theme.of(context).primaryColor
          : Theme.of(context).primaryColor,
    );
  }

  _setOutlineBorderRadius() {
    return BorderRadius.circular(widget.radius ?? Dimensions.radius * 0.5);
  }

  _setPadding() {
    return widget.customPadding ??
        (widget.padding == null
            ? EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize,
                vertical: Dimensions.widthSize * 1.4,
              )
            : EdgeInsets.all(widget.padding!));
  }

  _setPrefixIcon() {
    return widget.prefixIcon ??
        (widget.prefixIconPath != ''
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingHorizontalSize * 0.4),
                child: Row(
                  mainAxisSize: mainMin,
                  children: [
                    CustomImageWidget(
                      path: widget.prefixIconPath!,
                      color: focusNode!.hasFocus
                          ? Theme.of(context).primaryColor
                          : Get.isDarkMode
                              ? CustomColor.primaryDarkTextColor
                                  .withOpacity(0.50)
                              : CustomColor.primaryLightTextColor
                                  .withOpacity(0.50),
                    ),
                    Visibility(
                      visible: widget.phoneCode != '',
                      child: Row(
                        children: [
                          Text(
                            widget.phoneCode,
                            style: TextStyle(
                              fontSize: Dimensions.headingTextSize3,
                              fontWeight: FontWeight.w500,
                              color: focusNode!.hasFocus
                                  ? Theme.of(context).primaryColor
                                  : CustomColor.primaryLightTextColor
                                      .withOpacity(0.2),
                            ),
                          ).marginOnly(
                            left: Dimensions.marginSizeHorizontal * 0.3,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: Dimensions.marginSizeHorizontal * 0.3,
                            ),
                            height: Dimensions.heightSize * 1.5,
                            width: 1,
                            color: focusNode!.hasFocus
                                ? Theme.of(context).primaryColor
                                : CustomColor.primaryLightTextColor
                                    .withOpacity(0.2),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : null);
  }

  _setSuffixIcon() {
    return widget.isPasswordField
        ? IconButton(
            icon: Icon(
              isVisibility ? Iconsax.eye_slash : Iconsax.eye,
              color: focusNode!.hasFocus
                  ? Theme.of(context).primaryColor
                  : Get.isDarkMode
                      ? CustomColor.primaryDarkTextColor.withOpacity(0.50)
                      : CustomColor.primaryLightTextColor.withOpacity(0.50),
              size: Dimensions.iconSizeDefault,
            ),
            onPressed: () {
              setState(() {
                isVisibility = !isVisibility;
              });
            },
          )
        : widget.suffixIcon;
  }

  _setValidator() {
    return widget.isValidator == false
        ? null
        : (String? value) {
            if (value == null || value.isEmpty) {
              return DynamicLanguage.isLoading
                  ? ''
                  : DynamicLanguage.key(Strings.pleaseFillOutTheField)
                      .toString();
            } else {
              return null;
            }
          };
  }

  _buildShapeDecoration(BuildContext context) {
    return focusNode!.hasFocus
        ? widget.customShapeDecoration ??
            ShapeDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000), //TODO Change color
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            )
        : ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
            ),
          );
  }
}
