// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:test_package/main.dart';

enum SnackbarType { SUCCESS, ERROR, PROCESSING }

class CustomSnackbar {
  static show({
    required SnackbarType snackbarType,
    required String message,
    IconData? icon,
    Color? bgColor,
    Duration? duration,
  }) {
    final snackBar = SnackBar(
      padding: const EdgeInsets.all(12),
      elevation: 8,
      duration: duration ??
          (snackbarType == SnackbarType.PROCESSING ? const Duration(seconds: 5) : const Duration(seconds: 3)),
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.clip,
        ),
      ),
      backgroundColor: bgColor ??
          (snackbarType == SnackbarType.ERROR
              ? Colors.red.withOpacity(0.9)
              : snackbarType == SnackbarType.PROCESSING
                  ? Colors.green[900]
                  : Colors.green),
    );

    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}
