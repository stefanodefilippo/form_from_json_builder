import 'package:flutter/material.dart';
import 'package:form_from_json_builder/src/change_notifier/form_state_notifier.dart';
import 'package:form_from_json_builder/src/component/check_box_widget.dart';
import 'package:form_from_json_builder/src/component/drop_down_widget.dart';
import 'package:form_from_json_builder/src/component/text_field_widget.dart';
import 'package:form_from_json_builder/src/model/form_check_box.dart';
import 'package:form_from_json_builder/src/model/form_drop_down.dart';
import 'package:form_from_json_builder/src/model/form_text_field.dart';
import 'package:provider/provider.dart';

import 'model/form_model.dart';

typedef OnSubmit = Function(Map<String, dynamic> formValues);

class FormFromJson extends StatefulWidget {
  const FormFromJson({
    super.key,
    required this.jsonMap,
    this.formKey,
    this.textFieldDecoration,
    this.dropDownHintStyle,
    this.checkBoxLabelStyle,
    this.titleStyle,
    this.titleContainerDecoration,
    this.spaceAfterTitle,
    this.sectionTitleStyle,
    this.sectionTitleContainerDecoration,
    this.spaceBetweenQuestions,
    this.spaceBetweenSections,
    this.submitButtonTextStyle,
    this.submitButtonColor,
    this.submitButtonShapeBorder,
    this.onSubmit,
  });

  /// The json map to use to create the form.
  final Map<String, dynamic> jsonMap;

  /// The form GlobalKey
  final GlobalKey? formKey;

  ///InputDecoration for the Text Fields of the form
  final InputDecoration? textFieldDecoration;

  ///InputDecoration for the Dropdowns of the form
  final TextStyle? dropDownHintStyle;

  ///Text style for the Checkbox labels
  final TextStyle? checkBoxLabelStyle;

  ///Form title text style
  final TextStyle? titleStyle;

  ///Decoration for the form title container
  final BoxDecoration? titleContainerDecoration;

  ///Amount of free pixel to place below the form title
  final double? spaceAfterTitle;

  ///Text style of the title of each form section
  final TextStyle? sectionTitleStyle;

  ///Decoration for each section title container
  final BoxDecoration? sectionTitleContainerDecoration;

  ///Amount of free pixel placed between each question
  final double? spaceBetweenQuestions;

  ///Amount of free pixel placed between each section
  final double? spaceBetweenSections;

  ///Text style of the form submit button
  final TextStyle? submitButtonTextStyle;

  ///Color of the form submit button
  final Color? submitButtonColor;

  ///Shape border of the form submit button
  final ShapeBorder? submitButtonShapeBorder;

  /// The function called on submit button pressed
  final OnSubmit? onSubmit;

  @override
  State<FormFromJson> createState() => _FormFromJsonState();
}

class _FormFromJsonState extends State<FormFromJson> {
  FormModel? formModel;

  @override
  void initState() {
    formModel = FormModel.fromJson(widget.jsonMap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return formModel != null
        ? ChangeNotifierProvider(
            create: (context) => FormStateNotifier(),
            child: Consumer<FormStateNotifier>(
                builder: (context, provider, child) {
              return Column(
                children: [
                  Container(
                    decoration: widget.titleContainerDecoration,
                    child: formModel!.title != null
                        ? Text(
                            formModel!.title!,
                            style: widget.titleStyle,
                          )
                        : Container(),
                  ),
                  SizedBox(
                    height: widget.spaceAfterTitle,
                  ),
                  Form(
                    key: widget.formKey,
                    child: bodyFromModel(formModel!, context),
                  ),
                ],
              );
            }),
          )
        : Container();
  }

  Widget bodyFromModel(FormModel formModel, BuildContext context) {
    return Column(
      children: [
        ...formModel.formSections.map((formSection) {
          return Column(
            children: [
              Container(
                decoration: widget.sectionTitleContainerDecoration,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      formSection!.title!,
                      style: widget.sectionTitleStyle,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: widget.spaceBetweenQuestions,
              ),
              ...formSection.formElements.map((formElement) {
                switch (formElement.runtimeType) {
                  case FormTextField:
                    return Column(
                      children: [
                        TextFieldWidget(
                          formElement as FormTextField,
                          widget.textFieldDecoration,
                        ),
                        SizedBox(
                          height: widget.spaceBetweenQuestions,
                        )
                      ],
                    );
                  case FormCheckBox:
                    return Column(
                      children: [
                        CheckBoxWidget(
                          formElement as FormCheckBox,
                          widget.checkBoxLabelStyle,
                        ),
                        SizedBox(
                          height: widget.spaceBetweenQuestions,
                        )
                      ],
                    );
                  case FormDropDown:
                    return Column(
                      children: [
                        DropDownWidget(formElement as FormDropDown,
                            widget.dropDownHintStyle),
                        SizedBox(
                          height: widget.spaceBetweenQuestions,
                        )
                      ],
                    );
                  default:
                    return Container();
                }
              }).toList(),
              SizedBox(
                height: widget.spaceBetweenSections,
              )
            ],
          );
        }).toList(),
        MaterialButton(
          onPressed: () {
            if (widget.onSubmit != null) {
              widget.onSubmit!(
                  Provider.of<FormStateNotifier>(context, listen: false)
                      .formValues);
            }
          },
          shape: widget.submitButtonShapeBorder,
          color: widget.submitButtonColor,
          child: formModel.submitButtonTitle != null
              ? Text(
                  formModel.submitButtonTitle!,
                  style: widget.submitButtonTextStyle,
                )
              : Container(),
        )
      ],
    );
  }
}
