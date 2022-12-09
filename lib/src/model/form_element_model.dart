class FormElementModel{

  String? name;
  String? visible;
  bool? persistValue;

  FormElementModel.fromJson(Map<String, dynamic> json) :
        name = json["name"],
        visible = json["visible"],
        persistValue = json["persistValue"];

}