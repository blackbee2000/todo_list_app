import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_list/core/constants/app_dimension.dart';
import 'package:todo_list/core/widgets/dialog_customer_widget.dart';
import 'package:todo_list/core/widgets/snackbar_widget.dart';

class BaseController extends GetxController {
  void showConfirmDialog({
    required String content,
    required String title,
    IconData icon = Icons.warning,
    String textButtonCancel = 'Hủy',
    String textButtonConfirm = 'Xác nhận',
    VoidCallback? onTapCancel,
    VoidCallback? onTapConfirm,
  }) {
    if (Get.isDialogOpen!) {
      Get.back();
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimension.largeBorderRadius,
          ),
        ),
        insetPadding: EdgeInsets.zero,
        child: ConfirmDialog(
          title: title,
          content: content,
          icon: icon,
          textButtonCancel: textButtonCancel,
          textButtonConfirm: textButtonConfirm,
          onTapCancel: () {
            onTapCancel?.call();
            Get.back();
          },
          onTapConfirm: () {
            onTapConfirm?.call();
            Get.back();
          },
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<T?> showBaseBottomSheet<T>({
    required Widget widget,
    bool isDismissible = true,
    RouteSettings? settings,
  }) =>
      Get.bottomSheet<T>(
        widget,
        isScrollControlled: true,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimension.largeBorderRadius),
          ),
        ),
        enterBottomSheetDuration: const Duration(milliseconds: 300),
        exitBottomSheetDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        isDismissible: isDismissible,
        settings: settings,
      );

  void showErrorToast({required String message}) {
    final snackBar = SnackbarWidget.failed(
      screenSize: Get.size,
      title: 'Lỗi',
      message: message,
      onClose: ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar,
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  void showSuccessToast({required String message}) {
    final snackBar = SnackbarWidget.success(
      screenSize: Get.size,
      title: 'Thành công',
      message: message,
      onClose: ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar,
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  void showLoading() {
    if (EasyLoading.isShow) return;
    EasyLoading.show();
  }

  void hideLoading() {
    EasyLoading.dismiss(animation: true);
  }
}
