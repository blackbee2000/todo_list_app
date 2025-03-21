import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/core/themes/theme_controller.dart';
import 'package:todo_list/feature/app/controllers/base_controller.dart';
import 'package:todo_list/feature/domain/entities/todo_entity.dart';
import 'package:todo_list/feature/domain/repositories/todo_repository.dart';

class TodoCreateUpdateController extends BaseController {
  late final TodoRepository _todoRepository;
  final title = TextEditingController();
  final description = TextEditingController();
  final dueDate = TextEditingController(
    text: DateFormat('dd-MM-yyyy').format(
      DateTime.now(),
    ),
  );
  final dateSelected = DateTime.now().obs;
  final timeController = TextEditingController(
    text:
        "${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}",
  );
  final timeSelected = TimeOfDay.now().obs;
  final form = GlobalKey<FormState>();
  final Rxn<TodoEntity> todo = Rxn();
  final themeController = Get.find<ThemeController>();
  final isDone = false.obs;

  @override
  void onInit() async {
    _todoRepository = Get.find();
    mappingData();
    super.onInit();
  }

  /// Mapping for update todo
  void mappingData() {
    if (Get.arguments == null || Get.arguments is! TodoEntity) return;

    todo.value = Get.arguments;
    isDone.value = todo.value?.status ?? false;
    title.text = todo.value?.title ?? '';
    description.text = todo.value?.description ?? '';
    dateSelected.value = todo.value?.dueDate ?? DateTime.now();
    dueDate.text = DateFormat('dd-MM-yyyy').format(dateSelected.value);
    timeSelected.value = todo.value?.dueDate != null
        ? TimeOfDay(
            hour: todo.value!.dueDate!.hour,
            minute: todo.value!.dueDate!.minute,
          )
        : TimeOfDay.now();
    timeController.text =
        "${timeSelected.value.hour.toString().padLeft(2, '0')}:${timeSelected.value.minute.toString().padLeft(2, '0')}";
  }

  /// On submit
  Future<void> onSubmit() async {
    if (!form.currentState!.validate()) return;
    if (todo.value != null) {
      await updateTodo();
      return;
    }
    await createTodo();
  }

  /// Create todo
  Future<void> createTodo() async {
    showLoading();
    final dueDate = DateTime(
      dateSelected.value.year,
      dateSelected.value.month,
      dateSelected.value.day,
      timeSelected.value.hour,
      timeSelected.value.minute,
    );
    final todo = TodoEntity(
      title: title.text,
      description: description.text,
      dueDate: dueDate,
      createdAt: DateTime.now(),
    );

    final result = await _todoRepository.insertTodo(todo: todo);
    hideLoading();

    if (!result) {
      showErrorToast(message: 'Đã xảy ra lỗi khi tạo công việc mới');
    } else {
      showSuccessToast(message: 'Tạo công việc thành công');
      Get.back(result: true);
    }
  }

  /// Update todo
  Future<void> updateTodo() async {
    showLoading();
    final dueDate = DateTime(
      dateSelected.value.year,
      dateSelected.value.month,
      dateSelected.value.day,
      timeSelected.value.hour,
      timeSelected.value.minute,
    );
    final todoUpdate = todo.value?.copyWith(
      title: title.text,
      description: description.text,
      dueDate: dueDate,
      updatedAt: DateTime.now(),
    );

    final result = await _todoRepository.updateTodo(todo: todoUpdate!);
    hideLoading();

    if (!result) {
      showErrorToast(message: 'Đã xảy ra lỗi khi cập nhật công việc mới');
    } else {
      showSuccessToast(message: 'Cập nhật công việc thành công');
      Get.back(result: true);
    }
  }

  /// Select due date
  Future<void> selectDueDate() async {
    final result = await showDatePicker(
      context: Get.context!,
      initialDate: dateSelected.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2222),
    );

    if (result == null) return;
    dateSelected.value = result;
    dueDate.text = DateFormat('dd-MM-yyyy').format(
      dateSelected.value,
    );
  }

  /// Select time
  Future<void> selectTime() async {
    final result = await showTimePicker(
      context: Get.context!,
      initialTime: timeSelected.value,
    );
    if (result == null) return;
    timeSelected.value = result;
    timeController.text =
        "${timeSelected.value.hour.toString().padLeft(2, '0')}:${timeSelected.value.minute.toString().padLeft(2, '0')}";
  }
}
