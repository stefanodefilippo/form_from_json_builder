import 'package:form_from_json_builder/src/model/form_check_box.dart';
import 'package:form_from_json_builder/src/model/form_element_model.dart';
import 'package:form_from_json_builder/src/model/form_text_field.dart';

import 'form_drop_down.dart';

class FormSectionModel{

  String? title;
  List<FormElementModel?> formElements = [];

  FormSectionModel.fromJson(Map<String, dynamic> json) :
        title = json["title"],
        formElements = (json["elements"] as List).map(
                (formElement) {
                  switch(formElement["type"]){
                    case "textField":
                      return FormTextField.fromJson(formElement);
                    case "checkBox":
                      return FormCheckBox.fromJson(formElement);
                    case "dropDown":
                      return FormDropDown.fromJson(formElement);
                  }
                }).toList();

}