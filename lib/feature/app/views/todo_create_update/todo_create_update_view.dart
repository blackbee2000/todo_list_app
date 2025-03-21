import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/constants/app_dimension.dart';
import 'package:todo_list/core/themes/app_colors.dart';
import 'package:todo_list/core/widgets/app_bar_widget.dart';
import 'package:todo_list/core/widgets/rounded_button_widget.dart';
import 'package:todo_list/core/widgets/text_form_field_widget.dart';
import 'package:todo_list/feature/app/controllers/todo_create_update_controller.dart';
import 'package:todo_list/feature/app/views/base_view.dart';

class TodoCreateUpdateView extends BaseView<TodoCreateUpdateController> {
  const TodoCreateUpdateView({super.key});

  Widget _buildTitle({required String title}) => Row(
        children: [
          Obx(
            () => Text(
              title,
              style: TextStyle(
                color: controller.themeController.isDarkMode.value
                    ? Colors.white
                    : AppColors.kprimaryGreyColor,
                fontWeight: FontWeight.w700,
                fontSize: AppDimension.smallFontSize,
              ),
            ),
          ),
          const Text(
            ' *',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w700,
              fontSize: AppDimension.smallFontSize,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Obx(
      () => Scaffold(
        appBar: AppBarWidget(
          titleName: controller.todo.value != null
              ? controller.isDone.value
                  ? "Chi tiết công việc"
                  : 'Cập nhật công việc'
              : 'Tạo công việc',
          onLeadingTap: () => Get.back(result: false),
        ),
        bottomNavigationBar: controller.isDone.value
            ? null
            : Container(
                padding: EdgeInsets.fromLTRB(
                  AppDimension.mediumSpace,
                  AppDimension.mediumSpace,
                  AppDimension.mediumSpace,
                  max(
                    AppDimension.mediumSpace,
                    MediaQuery.of(context).viewPadding.bottom,
                  ),
                ),
                child: RoundedButtonWidget(
                  onPressed: () async => await controller.onSubmit(),
                  text: 'Lưu',
                ),
              ),
        body: Container(
          width: screenSize.width,
          height: screenSize.height,
          padding: const EdgeInsets.all(AppDimension.mediumSpace),
          child: SingleChildScrollView(
            child: Form(
              key: controller.form,
              child: Column(
                children: [
                  /// Title
                  _buildTitle(title: 'Tên công việc'),
                  const SizedBox(height: AppDimension.smallSpace),
                  TextFormFieldWidget(
                    controller: controller.title,
                    hintText: 'Nhập tên công việc',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Tên công việc là bắt buộc';
                      }
                      return null;
                    },
                    readOnly: controller.isDone.value,
                  ),
                  const SizedBox(height: AppDimension.mediumSpace),

                  /// Description
                  _buildTitle(title: 'Mô tả công việc'),
                  const SizedBox(height: AppDimension.smallSpace),
                  TextFormFieldWidget(
                    controller: controller.description,
                    hintText: 'Nhập mô tả công việc',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Mô tả công việc là bắt buộc';
                      }
                      return null;
                    },
                    readOnly: controller.isDone.value,
                  ),
                  const SizedBox(height: AppDimension.mediumSpace),

                  /// Due date
                  _buildTitle(title: 'Hạn hoàn thành'),
                  const SizedBox(height: AppDimension.smallSpace),
                  TextFormFieldWidget(
                    controller: controller.dueDate,
                    hintText: 'dd-MM-yyyy',
                    readOnly: true,
                    onTap: controller.isDone.value
                        ? null
                        : () async => await controller.selectDueDate(),
                    suffixIcon: IconButton(
                      onPressed: controller.isDone.value
                          ? null
                          : () async => await controller.selectDueDate(),
                      icon: const Icon(
                        Icons.calendar_month,
                        color: AppColors.kprimaryGreyColor,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimension.smallSpace),
                  TextFormFieldWidget(
                    controller: controller.timeController,
                    hintText: 'HH:mm',
                    readOnly: true,
                    onTap: controller.isDone.value
                        ? null
                        : () async => await controller.selectTime(),
                    suffixIcon: IconButton(
                      onPressed: controller.isDone.value
                          ? null
                          : () async => await controller.selectTime(),
                      icon: const Icon(
                        Icons.calendar_month,
                        color: AppColors.kprimaryGreyColor,
                        size: 24,
                      ),
                    ),
                    validator: (_) {
                      final dateTime = DateTime(
                        controller.dateSelected.value.year,
                        controller.dateSelected.value.month,
                        controller.dateSelected.value.day,
                        controller.timeSelected.value.hour,
                        controller.timeSelected.value.minute,
                      );
                      if (dateTime.compareTo(DateTime.now()) <= 0) {
                        return 'Vui lòng chọn thời gian phù hợp';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppDimension.mediumSpace),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
