import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/core/routes/app_routes.dart';
import 'package:todo_list/core/services/notification_local_service.dart';
import 'package:todo_list/core/themes/theme_controller.dart';
import 'package:todo_list/feature/app/controllers/base_controller.dart';
import 'package:todo_list/feature/domain/entities/todo_entity.dart';
import 'package:todo_list/feature/domain/repositories/todo_repository.dart';

class TodoListController extends BaseController {
  late final TodoRepository _todoRepository;
  final searchController = TextEditingController();
  final Rxn<DateTime> dateSelected = Rxn();
  final todos = <TodoEntity>[].obs;
  final themeController = Get.find<ThemeController>();
  Timer? _timer;

  @override
  void onInit() async {
    _todoRepository = Get.find();
    await _getAllTodo();

    /// Listen
    startListeningForDueDates();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startListeningForDueDates() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      final now = DateTime.now();
      for (var todo in todos) {
        if (todo.dueDate != null) {
          if (_isDue(todo.dueDate!, now) && !todo.status) {
            await NotificationService.showNotification(
              title: 'Thông báo',
              body: 'Đã đến hạn thực hiện công việc: ${todo.title ?? ''}'
                  ' vào thời gian ${todo.dueDate != null ? DateFormat('HH:mm dd-MM-yyyy').format(todo.dueDate!) : ''}',
            );
          }
        }
      }
    });
  }

  static bool _isDue(DateTime dueDate, DateTime now) {
    return dueDate.year == now.year &&
        dueDate.month == now.month &&
        dueDate.day == now.day &&
        dueDate.hour == now.hour &&
        dueDate.minute == now.minute;
  }

  /// Show picker date
  Future<void> showPickerDate() async {
    final result = await showDatePicker(
      context: Get.context!,
      initialDate: dateSelected.value,
      firstDate: DateTime(1990),
      lastDate: DateTime(2222),
    );

    dateSelected.value = result;
    await onSearchTodo(
      keySearch: searchController.text,
      dueDate: dateSelected.value,
    );
  }

  /// Go to create update todo
  Future<void> goToCreateUpdateToto({TodoEntity? todo}) async {
    /// Create todo
    final result = await Get.toNamed(
      AppRoutes.createUpdateTodoScreen,
      arguments: todo,
    );
    if (result == null || result is! bool) return;

    if (result) {
      await onRefresh();
    }
  }

  /// Get all todo
  Future<void> _getAllTodo() async {
    showLoading();
    final result = await _todoRepository.getAllTodo();
    hideLoading();
    todos.value = result.isNotEmpty ? result.reversed.toList() : [];
  }

  /// On refresh
  Future<void> onRefresh() async {
    await _getAllTodo();
  }

  /// Delete todo
  Future<void> deleteTodo({required TodoEntity todo}) async {
    showLoading();
    final result = await _todoRepository.deleteTodo(todo: todo);
    hideLoading();

    if (!result) {
      showErrorToast(
        message: 'Xoá công việc không thành công, vui lòng thử lại!',
      );
    } else {
      showSuccessToast(message: 'Xóa công việc thành công');
      await _getAllTodo();
    }
  }

  /// Search data
  Future<void> onSearchTodo({String? keySearch, DateTime? dueDate}) async {
    final result = await _todoRepository.searchTodo(
      keySearch: keySearch,
      dueDate: dueDate,
    );
    todos.value = result.isNotEmpty ? result.reversed.toList() : [];
    todos.refresh();
  }

  /// Check done todo
  Future<void> checkDoneTodo({
    required TodoEntity todo,
    required bool value,
  }) async {
    final todoUpdate = todo.copyWith(status: value);

    final result = await _todoRepository.updateTodo(todo: todoUpdate);

    if (result) {
      final result = await _todoRepository.getAllTodo();
      todos.value = result.isNotEmpty ? result.reversed.toList() : [];
      todos.refresh();
    }
  }
}
