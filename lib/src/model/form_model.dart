import 'package:form_from_json_builder/src/model/form_section_model.dart';

class FormModel{

  String? title;
  List<FormSectionModel?> formSections = [];
  String? submitButtonTitle;

  FormModel.fromJson(Map<String, dynamic> json) :
        title = json["title"],
        formSections = (json["sections"] as List).map(
                (formSection) => FormSectionModel.fromJson(formSection)
        ).toList(),
        submitButtonTitle = json["submitButtonTitle"];

}