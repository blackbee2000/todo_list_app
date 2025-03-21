import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/app_dimension.dart';
import 'package:todo_list/core/themes/app_colors.dart';

class EmptyTodoWidget extends StatelessWidget {
  const EmptyTodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 30, color: AppColors.kprimaryColor),
        SizedBox(height: AppDimension.smallSpace),
        Text(
          'Không có công việc nào',
          style: TextStyle(
            color: AppColors.kprimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: AppDimension.largeFontSize,
          ),
        ),
      ],
    );
  }
}
