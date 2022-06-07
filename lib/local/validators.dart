// ignore_for_file: non_constant_identifier_names, prefer_function_declarations_over_variables

//VALIDADORES
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ],
);

final idValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'id is required'),
    MinLengthValidator(10, errorText: 'id must be at least 10 digits long'),
    PatternValidator(r'^[0-9]*$', errorText: 'id must have only numbers')
  ],
);

class MaxIntValidator extends FieldValidator<int> {
  int maxValue;
  MaxIntValidator({required String errorText, required this.maxValue})
      : super(errorText);

  @override
  bool isValid(value) {
    if (value > maxValue) return false;
    return true;
  }
}

final maxValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'id is required'),
    MaxIntValidator(errorText: 'mayyor a 100', maxValue: 100),
    PatternValidator(r'^[0-9]*$', errorText: 'id must have only numbers')
  ],
);

class CustomRequiredValidator extends TextFieldValidator {
  final ctx;
  CustomRequiredValidator({required String errorText, required this.ctx})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    return value != null && value != '' && value != "0";
  }

  @override
  String? call(String? value) {
    if (isValid(value)) {
      return null;
    } else {
      SweetAlert.show(ctx,
          curve: ElasticInCurve(),
          title: errorText,
          style: SweetAlertStyle.error, onPress: (bool isConfirm) {
        Get.close(1);
        return false;
      });
      return errorText;
    }
  }
}

class CustomCatalogRequiredValidator extends TextFieldValidator {
  final ctx;
  final catalog;
  CustomCatalogRequiredValidator(
      {required String errorText, required this.ctx, required this.catalog})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    return value != null && value != '' && value != "0" && catalog.isNotEmpty;
  }

  @override
  String? call(String? value) {
    if (isValid(value)) {
      return null;
    } else {
      SweetAlert.show(ctx,
          curve: ElasticInCurve(),
          title: errorText,
          style: SweetAlertStyle.error, onPress: (bool isConfirm) {
        Get.close(1);
        return false;
      });
      return errorText;
    }
  }
}

final CustomDatetimeRequiredValidator =
    (DateTime? date, {BuildContext? context, required String errorText}) {
  if (date != null) {
    return null;
  } else {
    SweetAlert.show(context,
        curve: ElasticInCurve(),
        title: errorText,
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
      Get.close(1);
      return false;
    });
    return false;
  }
};

class CustomDatetimeGreaterValidator extends FieldValidator<DateTime?> {
  static String _errorText = '';
  DateTime compare = DateTime.now();
  BuildContext? context;
  bool invert = false;
  CustomDatetimeGreaterValidator(
      {required this.context,
      required this.compare,
      required String errorText,
      this.invert = false})
      : super(_errorText) {
    _errorText = errorText;
  }

  @override
  bool isValid(value) {
    int inv = invert ? -1 : 1;
    var diff = compare.difference(value!).inDays * inv;
    var newDate = value.difference(DateTime.now()).inDays;

    if ((diff > 0) && (newDate >= 0)) {
      return true;
    } else {
      SweetAlert.show(context,
          curve: ElasticInCurve(),
          title: _errorText,
          style: SweetAlertStyle.error, onPress: (bool isConfirm) {
        return true;
      });
    }

    return false;
  }

  @override
  String? call(dynamic value) {
    return isValid(value) ? null : _errorText;
  }
}

final CustomMultiDropdownRequiredValidator =
    (value, {BuildContext? context, required String errorText}) {
  if (value == null) {
    SweetAlert.show(context,
        curve: ElasticInCurve(),
        title: errorText,
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
      Get.close(1);
      return false;
    });
  }
};
