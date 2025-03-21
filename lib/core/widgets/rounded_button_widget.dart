import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/app_dimension.dart';
import 'package:todo_list/core/themes/app_colors.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({
    super.key,
    this.width,
    this.height = 50,
    this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.textSize = AppDimension.largeFontSize,
    this.fontWeight = FontWeight.w700,
    this.fontStyle = FontStyle.normal,
    this.backgroundColor = AppColors.kprimaryColor,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(
        AppDimension.smallBorderRadius,
      ),
    ),
    this.borderColor = AppColors.kprimaryColor,
    this.borderSize = 1.0,
    this.padding = const EdgeInsets.all(10),
    this.disable = false,
    this.align = TextAlign.center,
    this.icon,
  });

  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final String text;
  final Color textColor;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double textSize;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Color borderColor;
  final double borderSize;
  final EdgeInsetsGeometry padding;
  final bool disable;
  final TextAlign align;
  final Widget? icon;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disable ? null : onPressed,
          borderRadius: borderRadius,
          child: Ink(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color:
                  disable ? backgroundColor.withOpacity(0.5) : backgroundColor,
              border: Border.all(
                color: disable ? borderColor.withOpacity(0.5) : borderColor,
                width: borderSize,
              ),
              borderRadius: borderRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Container(
                    margin: const EdgeInsets.only(
                      right: AppDimension.mediumSpace,
                    ),
                    child: icon,
                  ),
                Text(
                  text.toUpperCase(),
                  maxLines: 2,
                  textAlign: align,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: textSize,
                    fontWeight: fontWeight,
                    fontStyle: fontStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
