import 'package:flutter/material.dart';
import 'package:form_from_json_builder/src/change_notifier/form_state_notifier.dart';
import 'package:form_from_json_builder/src/model/form_text_field.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(this.formTextField, this.inputDecoration, {Key? key})
      : super(key: key);

  final FormTextField formTextField;
  final InputDecoration? inputDecoration;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  FormStateNotifier? formStateNotifier;
  bool visible = false;
  TextEditingController textEditingController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    checkPersistence();
    super.initState();
  }

  checkPersistence() async {
    if (widget.formTextField.persistValue == true &&
        widget.formTextField.name != null) {
      textEditingController.text =
          (await Utils.getStoredStringValue(widget.formTextField.name!)) ?? "";
      formStateNotifier!
          .addOrUpdate(widget.formTextField.name!, textEditingController.text);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    formStateNotifier = Provider.of<FormStateNotifier>(context, listen: true);

    visible = widget.formTextField.visible != null
        ? Utils.parseConditionalExpression(
            widget.formTextField.visible!, formStateNotifier!.formValues)
        : true;

    if (!visible) {
      textEditingController.text = "";
      formStateNotifier!.addOrUpdateNoNotify(
          widget.formTextField.name!, textEditingController.text);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : Visibility(
            visible: visible,
            child: TextFormField(
              controller: textEditingController,
              onChanged: (String newValue) {
                if (widget.formTextField.name != null) {
                  formStateNotifier!
                      .addOrUpdate(widget.formTextField.name!, newValue);
                  if (widget.formTextField.persistValue == true) {
                    Utils.persistStringValue(
                        widget.formTextField.name!, newValue);
                  }
                }
              },
              decoration: widget.inputDecoration != null
                  ? widget.inputDecoration!
                      .copyWith(labelText: widget.formTextField.labelText)
                  : InputDecoration(
                      labelText: widget.formTextField.labelText,
                    ),
              keyboardType: widget.formTextField.keyboardType,
            ),
          );
  }
}
