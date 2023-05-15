import 'dart:math';

import 'package:intl/intl.dart';

import '../constants/constant.dart';

extension StringExtension on String {
  String lastChars(int n) => length >= n ? substring(length - n) : this;

  String firstChars(int n) => substring(0, min(length, n));

  String get normalizeSpace => split(' ').where((word) => word.isNotEmpty).join(' ').trim();

  String get removeSeparators => replaceAll(RegExp(r'[\s-]'), '');

  String get removeLowercase => replaceAll(RegExp(r'\p{Ll}'), '');

  bool get isNotEmptyValid => trim().isNotEmpty;

  bool get validName => isNotEmpty && Constant.nameValidationRegex.stringMatch(this) == this;

  bool get validEmail => isNotEmpty && Constant.emailRegex.stringMatch(this) == this;

  bool validPositiveInteger({num? upperLimit}) => isNotEmpty && toNum > 0 && (upperLimit == null || toNum <= upperLimit);

  String toDdMmYyyy() => DateFormat('dd/MM/yyyy').format(
        DateFormat('yyyy-MM-dd').parse(this),
      );

  String getDigits() => replaceAll(RegExp(r'[\D]'), '');

  num get toNum => isNumeric ? num.parse(this) : 0;

  bool get isNumeric => num.tryParse(this) != null;
}
