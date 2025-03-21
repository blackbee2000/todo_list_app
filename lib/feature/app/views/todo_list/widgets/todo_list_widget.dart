import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/core/constants/app_dimension.dart';
import 'package:todo_list/core/themes/app_colors.dart';
import 'package:todo_list/feature/app/controllers/todo_list_controller.dart';

class TodoListWidget extends StatelessWidget {
  final TodoListController controller;
  const TodoListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await controller.onRefresh(),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.todos.length,
        itemBuilder: (ct, i) {
          final todo = controller.todos[i];
          return GestureDetector(
            onTap: () async => await controller.goToCreateUpdateToto(
              todo: todo,
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                bottom: AppDimension.mediumSpace,
              ),
              padding: const EdgeInsets.fromLTRB(
                0,
                AppDimension.mediumSpace,
                AppDimension.mediumSpace,
                AppDimension.mediumSpace,
              ),
              decoration: BoxDecoration(
                color: todo.status ? AppColors.kGreenLightColor : Colors.white,
                borderRadius: BorderRadius.circular(
                  AppDimension.mediumBorderRadius,
                ),
                border: Border.all(
                  color: todo.status
                      ? AppColors.kprimaryColor
                      : AppColors.kprimaryBorderColor,
                ),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: todo.status,
                    onChanged: (bool? value) async =>
                        await controller.checkDoneTodo(
                      todo: todo,
                      value: value ?? false,
                    ),
                    checkColor: Colors.white,
                    activeColor: AppColors.kprimaryColor,
                    side: BorderSide(
                      color: todo.status
                          ? AppColors.kprimaryColor
                          : AppColors.kprimaryGreyColor,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title ?? '--',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: AppDimension.mediumFontSize,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: AppDimension.smallSpace / 2),
                        Text(
                          todo.description ?? '--',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: AppDimension.mediumFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: AppDimension.smallSpace / 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 20,
                              color: AppColors.kprimaryGreyColor,
                            ),
                            const SizedBox(width: AppDimension.smallSpace),
                            Text(
                              todo.dueDate != null
                                  ? DateFormat('HH:mm dd-MM-yyyy')
                                      .format(todo.dueDate!)
                                  : '--',
                              style: const TextStyle(
                                color: AppColors.kprimaryGreyColor,
                                fontSize: AppDimension.mediumFontSize,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.showConfirmDialog(
                      title: 'Cảnh báo',
                      content: 'Bạn muốn xóa công việc này?',
                      onTapConfirm: () async => await controller.deleteTodo(
                        todo: todo,
                      ),
                    ),
                    child: const Icon(
                      Icons.delete_outline,
                      size: 30,
                      color: AppColors.kprimaryGreyColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
