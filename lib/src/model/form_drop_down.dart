import 'package:form_from_json_builder/src/model/form_drop_down_item.dart';
import 'package:form_from_json_builder/src/model/form_element_model.dart';

class FormDropDown extends FormElementModel {
  List<FormDropDownItem?> items = [];
  String? hint;

  FormDropDown.fromJson(Map<String, dynamic> json)
      : items = (json["items"] as List)
            .map((item) => FormDropDownItem.fromJson(item))
            .toList(),
        hint = json["labelText"],
        super.fromJson(json);
}
