import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/constants/app_dimension.dart';
import 'package:todo_list/core/themes/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String titleName;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onLeadingTap;
  final Color? leadingColor;
  final double? leadingWidth;
  final double elevation;
  final bool centerTitle;
  final Widget? customeTitle;

  const AppBarWidget({
    super.key,
    required this.titleName,
    this.leading,
    this.actions,
    this.onLeadingTap,
    this.leadingColor,
    this.leadingWidth,
    this.elevation = 0,
    this.centerTitle = true,
    this.customeTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      centerTitle: centerTitle,
      title: customeTitle ??
          Text(
            titleName.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: AppDimension.largeFontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
      backgroundColor: AppColors.kprimaryColor,
      leading: leadingWidth == 0
          ? null
          : leading ??
              IconButton(
                onPressed: onLeadingTap ?? Get.back,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 22,
                  color: Colors.white,
                ),
              ),
      leadingWidth: leadingWidth,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
