import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/constants/app_dimension.dart';
import 'package:todo_list/core/widgets/rounded_button_widget.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final String textButtonCancel;
  final String textButtonConfirm;
  final VoidCallback onTapCancel;
  final VoidCallback onTapConfirm;
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    this.icon = Icons.warning,
    required this.textButtonCancel,
    required this.textButtonConfirm,
    required this.onTapCancel,
    required this.onTapConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: Get.width - (AppDimension.largeSpace * 4),
        padding: const EdgeInsets.all(AppDimension.mediumSpace),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppDimension.largeBorderRadius,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 50, color: Colors.yellow),
            const SizedBox(height: AppDimension.mediumSpace),
            Text(
              title,
              style: const TextStyle(
                fontSize: AppDimension.extraLargeFontSize,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: AppDimension.mediumSpace),
            Text(
              content,
              style: const TextStyle(
                fontSize: AppDimension.mediumFontSize,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppDimension.mediumSpace),
            Row(
              children: [
                Expanded(
                  child: RoundedButtonWidget(
                    onPressed: onTapCancel,
                    text: textButtonCancel,
                  ),
                ),
                const SizedBox(width: AppDimension.smallSpace),
                Expanded(
                  child: RoundedButtonWidget(
                    onPressed: onTapConfirm,
                    text: textButtonConfirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
