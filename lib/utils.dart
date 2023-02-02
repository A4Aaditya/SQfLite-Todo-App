import 'package:flutter/material.dart';

SnackBar createdSnackBar({required String message, required Color color}) {
  return SnackBar(
    content: Text(message),
    backgroundColor: color,
  );
}

String? validateField({
  required TextEditingController controller,
  required String errorMessage,
}) {
  if (controller.text.isEmpty) {
    return errorMessage;
  }
  return null;
}
