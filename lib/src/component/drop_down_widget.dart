import 'package:flutter/material.dart';
import 'package:form_from_json_builder/src/change_notifier/form_state_notifier.dart';
import 'package:form_from_json_builder/src/model/form_drop_down.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget(
      this.formDropDown,
      this.hintStyle,
      {Key? key}
      ) : super(key: key);

  final FormDropDown formDropDown;
  final TextStyle? hintStyle;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {

  FormStateNotifier? formStateNotifier;
  String? selectedValue;
  bool visible = false;
  bool isLoading = true;

  @override
  void initState() {
    checkPersistence();
    super.initState();
  }

  checkPersistence() async {
    if(widget.formDropDown.persistValue == true && widget.formDropDown.name != null){
      selectedValue = (await Utils.getStoredStringValue(widget.formDropDown.name!)) ?? "";
      if(selectedValue != null){
        formStateNotifier!.addOrUpdate(widget.formDropDown.name!, selectedValue);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    formStateNotifier = Provider.of<FormStateNotifier>(context, listen: true);

    visible = widget.formDropDown.visible != null ?
    Utils.parseConditionalExpression(widget.formDropDown.visible!, formStateNotifier!.formValues) :
    true;

    if(!visible){
      selectedValue = null;
      formStateNotifier!.addOrUpdateNoNotify(widget.formDropDown.name!, selectedValue);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return isLoading ? Container() : Visibility(
      visible: visible,
      child: DropdownButton(
        value: selectedValue,
        hint: widget.formDropDown.hint != null ? Text(
          widget.formDropDown.hint!,
          style: widget.hintStyle,
        ) : Container(),
        items: widget.formDropDown.items.map(
                (item) {
                  return DropdownMenuItem(
                      value: item?.value,
                      child: Text(item!.text)
                  );
                }
                ).toList(),
        onChanged: (newValue){
          setState(() {
            selectedValue = newValue;
          });
          if(widget.formDropDown.name != null){
            formStateNotifier!.addOrUpdate(widget.formDropDown.name!, newValue);
            if(widget.formDropDown.persistValue == true){
              Utils.persistStringValue(widget.formDropDown.name!, newValue.toString());
            }
          }
        },
      ),
    );

  }
}
