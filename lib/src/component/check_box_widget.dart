import 'package:flutter/material.dart';
import 'package:form_from_json_builder/src/change_notifier/form_state_notifier.dart';
import 'package:provider/provider.dart';
import '../model/form_check_box.dart';
import '../utils/utils.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget(this.formCheckBox, this.labelStyle, {Key? key})
      : super(key: key);

  final FormCheckBox formCheckBox;
  final TextStyle? labelStyle;

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  FormStateNotifier? formStateNotifier;
  bool isChecked = false;
  bool visible = true;
  bool isLoading = true;

  @override
  void initState() {
    checkPersistence();
    super.initState();
  }

  checkPersistence() async {
    if (widget.formCheckBox.persistValue == true &&
        widget.formCheckBox.name != null) {
      isChecked =
          (await Utils.getStoredBoolValue(widget.formCheckBox.name!)) ?? false;
      formStateNotifier!.addOrUpdate(widget.formCheckBox.name!, isChecked);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    formStateNotifier = Provider.of<FormStateNotifier>(context, listen: true);

    visible = widget.formCheckBox.visible != null
        ? Utils.parseConditionalExpression(
            widget.formCheckBox.visible!, formStateNotifier!.formValues)
        : true;

    if (!visible) {
      isChecked = false;
      formStateNotifier!
          .addOrUpdateNoNotify(widget.formCheckBox.name!, isChecked.toString());
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : Visibility(
            visible: visible,
            child: Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (newValue) {
                    setState(() {
                      isChecked = newValue!;
                    });
                    if (widget.formCheckBox.name != null) {
                      formStateNotifier!
                          .addOrUpdate(widget.formCheckBox.name!, newValue);
                      if (widget.formCheckBox.persistValue == true) {
                        Utils.persistBoolValue(
                            widget.formCheckBox.name!, newValue!);
                      }
                    }
                  },
                ),
                widget.formCheckBox.label != null
                    ? Expanded(
                        child: Text(
                          widget.formCheckBox.label!,
                          style: widget.labelStyle,
                        ),
                      )
                    : Container()
              ],
            ),
          );
  }
}
