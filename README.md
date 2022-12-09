<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Create a dynamic form starting from a Json input.
This package is useful if your app or website contains one or more forms that you want to update (remove or add questions and sections) without doing a deploy.
You will store the json representing the form in a database or file and you will input it to the FormFromJson widget: it will create dynamically your form.

## Features

- Create a form with a title and multiple sections starting from a json input
- In each section you can put the following types of form elements:
    - Text fields
    - Dropdowns
    - Checkboxes
- Foreach element you can specify the 'visible' property with a boolean expression to tell if that element is visible in the form


## Usage

Input to the FormFromJson widget a json that follows the following schema

```json
{
  "type": "object",
  "properties": {
    "title": {
      "type": "string"
    },
    "submitButtonTitle": {
      "type": "string"
    },
    "sections": {
      "type": "array",
      "items": [
        {
          "type": "object",
          "properties": {
            "title": {
              "type": "string"
            },
            "elements": {
              "type": "array",
              "items": [
                {
                  "type": "object",
                  "properties": {
                    "type": {
                      "type": "string"
                    },
                    "name": {
                      "type": "string"
                    },
                    "labelText": {
                      "type": "string"
                    },
                    "keyboardType": {
                      "type": "string"
                    },
                    "persistValue": {
                      "type": "boolean"
                    },
                    "visible": {
                      "type": "string"
                    },
                    "items": {
                      "type": "array",
                      "items": [
                        {
                          "type": "object",
                          "properties": {
                            "text": {
                              "type": "string"
                            },
                            "value": {
                              "type": "string"
                            }
                          },
                          "required": [
                            "text"
                          ]
                        }
                      ]
                    },
                    "required": [
                      "type"
                    ]
                  }
                }
              ]
            }
          },
          "required": [
            "elements"
          ]
        }
      ]
    }
  },
  "required": [
    "sections"
  ]
}
```

The form elements are contained in the `elements` array.
The properties supported by each element type are `type`, `name`, `labelText`, `persistValue` and `visible`
- `type`: the element type (see next section)
- `name`: the element name
- `labelText`: the element label/hint text
- `persistValue`: set it to true if you need to reload the question actual value in the next app sessions. NOTE this property works if you have set the `name` property
- `visible`: boolean expression that says if this element is visible or not in the form

The supported element types (field `type`) are the following:
- `textField`, that additionally supports the following property: `keyboardType`
- `checkBox`
- `dropDown`, that additionally supports the following property: `items`, containing an array of tuples representing the dropdown menu items

## Additional information

The actual supported form elements are:
- Text fields
- Dropdowns
- Checkboxes

Fell free to contribute to this library adding more supported form elements and more features.

# example

Example project for form_from_json package
