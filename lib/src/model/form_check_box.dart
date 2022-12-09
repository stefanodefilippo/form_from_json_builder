import 'package:form_from_json_builder/src/model/form_element_model.dart';

class FormCheckBox extends FormElementModel{

  String? label;

  FormCheckBox.fromJson(Map<String, dynamic> json) :
        label = json["labelText"],
        super.fromJson(json);

}