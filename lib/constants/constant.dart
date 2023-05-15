import 'package:flutter/material.dart';

class Constant {
  static const double cardElevation = 0.4;

  static const double cardItemBorderSize = 0.5;

  static const FontWeight fontWeightBold = FontWeight.bold;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightLight = FontWeight.w300;

  static const int nameLength = 64;
  static const int maxNameLength = 32;
  static const int maxEmailLength = 64;

  static const int int32MaxValue = 2147483647;

  static final RegExp emailRegex = RegExp(
    r"(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"
    r'"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])',
  );

  static final RegExp nameValidationRegex = RegExp(
    r"^([\p{L}\p{M}0-9])$|^([\p{L}\p{M}0-9]|-|\.|'|_)+(([^\S\r\n])*([\p{L}\p{M}0-9])+)+$",
    unicode: true,
  );
}
