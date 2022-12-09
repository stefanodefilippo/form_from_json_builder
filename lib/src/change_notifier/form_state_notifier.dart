import 'package:flutter/material.dart';

class FormStateNotifier extends ChangeNotifier {
  Map<String, dynamic> formValues = {};

  void addOrUpdate(String key, dynamic value) {
    formValues[key] = value ?? "";
    notifyListeners();
  }

  void addOrUpdateNoNotify(String key, dynamic value) {
    formValues[key] = value ?? "";
  }
}
