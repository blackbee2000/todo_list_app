import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/constants/app_dimension.dart';
import 'package:todo_list/core/themes/app_colors.dart';
import 'package:todo_list/core/widgets/app_bar_widget.dart';
import 'package:todo_list/core/widgets/text_form_field_widget.dart';
import 'package:todo_list/feature/app/controllers/todo_list_controller.dart';
import 'package:todo_list/feature/app/views/base_view.dart';
import 'package:todo_list/feature/app/views/todo_list/widgets/empty_todo_widget.dart';
import 'package:todo_list/feature/app/views/todo_list/widgets/todo_list_widget.dart';

class TodoListView extends BaseView<TodoListController> {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(
        titleName: 'Danh sách công việc',
        leadingWidth: 0,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () => controller.themeController.toggleTheme(),
              icon: Icon(
                Icons.dark_mode,
                size: 24,
                color: controller.themeController.isDarkMode.value
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await controller.goToCreateUpdateToto(),
        backgroundColor: AppColors.kprimaryColor,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: const EdgeInsets.all(AppDimension.mediumSpace),
        child: Column(
          children: [
            /// Filter
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: TextFormFieldWidget(
                      controller: controller.searchController,
                      hintText: 'Nhập tìm kiếm',
                      onChanged: (String? value) async {
                        if (value != null) {
                          await controller.onSearchTodo(
                            keySearch: value,
                            dueDate: controller.dateSelected.value,
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: AppDimension.smallSpace),
                Obx(
                  () => InkWell(
                    onTap: () async => await controller.showPickerDate(),
                    borderRadius: BorderRadius.circular(
                      AppDimension.smallBorderRadius,
                    ),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: controller.themeController.isDarkMode.value
                            ? Colors.white
                            : null,
                        border:
                            Border.all(color: AppColors.kprimaryBorderColor),
                        borderRadius: BorderRadius.circular(
                          AppDimension.smallBorderRadius,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.calendar_month,
                          size: 22,
                          color: AppColors.kprimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimension.mediumSpace),

            /// List
            Expanded(
              child: Obx(
                () => controller.todos.isNotEmpty
                    ? TodoListWidget(controller: controller)
                    : const EmptyTodoWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
