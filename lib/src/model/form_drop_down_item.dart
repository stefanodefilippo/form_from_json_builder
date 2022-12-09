class FormDropDownItem {
  String value;
  String text;

  FormDropDownItem.fromJson(Map<String, dynamic> json)
      : value = json["value"],
        text = json["text"];
}
