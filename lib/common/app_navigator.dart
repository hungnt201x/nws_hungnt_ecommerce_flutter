import 'package:another_flushbar/flushbar.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  BuildContext context;

  AppNavigator({required this.context});

  void pop<T extends Object?>([T? result]) {
    GoRouter.of(context).pop(result);
  }

  void forceSignIn() {
    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
    GoRouter.of(context).pushReplacementNamed(AppRouter.signIn);
  }

  /// Show dialog
  Future<void> showSimpleDialog({
    String title = "Alert",
    String message = "",
    String? textConfirm = "Yes",
    String? textCancel = "No",
    barrierDismissible = false,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          title: Text(
            title,
            style: AppTextStyle.blackS20W800,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Text(message, style: AppTextStyle.greyA16),
              ],
            ),
          ),
          actions: <Widget>[
            textConfirm != null
                ? TextButton(
                    child: Text(textConfirm),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm?.call();
                    },
                  )
                : const SizedBox(),
            textCancel != null
                ? TextButton(
                    child: Text(textCancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }

  /// Show error flushbar
  void showErrorFlushbar({required String message}) {
    Flushbar(
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      message: message,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(
        Icons.error_outline,
        size: 28.0,
        color: Colors.white,
      ),
      titleColor: Colors.white,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
    ).show(context);
  }

  void showSuccessFlushbar({required String message}) {
    Flushbar(
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      message: message,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(
        Icons.check_circle_outline,
        size: 28.0,
        color: Colors.white,
      ),
      titleColor: Colors.white,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
    ).show(context);
  }
}
