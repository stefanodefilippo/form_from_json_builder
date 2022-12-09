import 'package:flutter/material.dart';
import 'package:form_from_json_builder/src/model/form_element_model.dart';

class FormTextField extends FormElementModel {
  String? labelText;
  TextInputType? keyboardType;

  FormTextField.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    labelText = json["labelText"];
    switch (json["keyboardType"]) {
      case "number":
        keyboardType = TextInputType.number;
        break;
      case "text":
        keyboardType = TextInputType.text;
        break;
    }
  }
}
