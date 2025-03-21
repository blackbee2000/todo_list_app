import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/app_dimension.dart';
import 'package:todo_list/core/themes/app_colors.dart';

class SnackbarWidget {
  static SnackBar _base({
    required Size screenSize,
    required Icon leadingIcon,
    required Color backgroundColor,
    required String title,
    required String message,
    Function()? onClose,
    required Color textTitleColor,
    required Color borderColor,
  }) =>
      SnackBar(
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: screenSize.height * .68),
        elevation: 0,
        duration: const Duration(milliseconds: 1500),
        content: GestureDetector(
          onVerticalDragUpdate: (detail) {
            if (detail.delta.dy < 0) {
              onClose?.call();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(AppDimension.mediumSpace),
            constraints: const BoxConstraints(minHeight: 80),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(
                AppDimension.mediumBorderRadius,
              ),
            ),
            child: Row(
              children: [
                leadingIcon,
                const SizedBox(
                  width: AppDimension.smallSpace,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: textTitleColor,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimension.mediumFontSize,
                        ),
                      ),
                      const SizedBox(
                        height: AppDimension.smallSpace / 3,
                      ),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: AppDimension.mediumFontSize,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  static SnackBar success({
    required Size screenSize,
    required String title,
    required String message,
    Function()? onClose,
  }) =>
      _base(
        screenSize: screenSize,
        leadingIcon: const Icon(
          Icons.check_circle_outline,
          color: AppColors.kprimaryColor,
        ),
        backgroundColor: AppColors.kGreenLightColor,
        borderColor: AppColors.kprimaryColor,
        title: title,
        message: message,
        onClose: onClose,
        textTitleColor: AppColors.kprimaryColor,
      );

  static SnackBar failed({
    required Size screenSize,
    required String title,
    required String message,
    Function()? onClose,
  }) =>
      _base(
        screenSize: screenSize,
        leadingIcon: const Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
        backgroundColor: AppColors.kRedLightColor,
        title: title,
        message: message,
        onClose: onClose,
        textTitleColor: Colors.red,
        borderColor: Colors.red,
      );
}
