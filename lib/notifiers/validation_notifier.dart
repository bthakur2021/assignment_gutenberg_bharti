import 'package:flutter/cupertino.dart';

class ValidationNotifier extends ChangeNotifier {
  ValidationNotifier({
    this.errorText = '',
  });

  final String errorText;

  bool isValid = true;

  bool _shouldValidate = false;

  bool get shouldValidate => _shouldValidate;

  void validate() {
    _shouldValidate = true;
    notifyListeners();
    _shouldValidate = false;
  }
}
