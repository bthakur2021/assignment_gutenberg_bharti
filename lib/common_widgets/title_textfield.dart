import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/validation_notifier.dart';
import 'error_indicator_widget.dart';

class TitleTextField extends StatefulHookConsumerWidget {
  const TitleTextField({
    required this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.onPrefixTap,
    this.onSuffixTap,
    this.controller,
    this.decoration,
    this.onChanged,
    this.validator,
    this.formValidate = false,
    this.inputFormatters,
    this.keyboardType,
    this.obscureText = false,
    this.titleTextStyle,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.maxLines = 1,
    this.autofillHints,
    this.focusNode,
    this.shouldValidate,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.showErrorIcon = true,
    Key? key,
  })  : assert(onPrefixTap == null || prefixIcon != null),
        super(key: key);

  final String title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onPrefixTap;
  final VoidCallback? onSuffixTap;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final ValueChanged<String>? onChanged;
  final String? Function(String)? validator;
  final bool formValidate;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextStyle? titleTextStyle;
  final TextAlign textAlign;
  final int? maxLength;
  final int? maxLines;
  final List<String>? autofillHints;
  final FocusNode? focusNode;
  final ValidationNotifier? shouldValidate;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final bool showErrorIcon;

  @override
  ConsumerState<TitleTextField> createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends ConsumerState<TitleTextField> {
  late AppLocalizations localizations = AppLocalizations.of(context)!;

  String? error;
  late final controller = widget.controller ?? TextEditingController();

  late final FocusNode _focusNode = (widget.focusNode ?? FocusNode())
    ..addListener(() async {
      if (!_focusNode.hasFocus) {
        error = widget.validator?.call(controller.text);
        setState(() {});
      }
    });

  bool get isError => error != null && error!.isNotEmpty;

  bool get isValid => widget.shouldValidate?.isValid ?? true;

  @override
  void initState() {
    super.initState();
    widget.shouldValidate?.addListener(() async {
      _validateAndCheckError();
    });
  }

  void _validateAndCheckError() {
    if (widget.shouldValidate?.shouldValidate ?? false) {
      error = null;
      widget.shouldValidate?.isValid = true;

      final text = controller.text;
      if (text.isEmpty) {
        error = localizations.errorEmptyInput;
      } else {
        error = widget.validator?.call(text);
      }

      if (error != null && error!.isNotEmpty) {
        widget.shouldValidate?.isValid = false;
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: widget.maxLines ?? 1,
                decoration: widget.decoration ??
                    InputDecoration(
                      labelText: widget.title,
                      contentPadding: const EdgeInsets.all(16.0),
                      prefixIcon: widget.prefixIcon == null
                          ? null
                          : Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: InkWell(
                                onTap: widget.onPrefixTap,
                                child: widget.prefixIcon,
                              ),
                            ),
                      suffixIcon: widget.suffixIcon == null
                          ? null
                          : Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: InkWell(
                                onTap: widget.onSuffixTap,
                                child: widget.suffixIcon,
                              ),
                            ),
                    ),
                autocorrect: false,
                controller: controller,
                validator: (value) {
                  if (widget.formValidate) {
                    _validateAndCheckError();
                    return isValid ? null : error;
                  }

                  widget.shouldValidate?.isValid = true;
                  return null;
                },
                onChanged: (text) async {
                  _validateAndCheckError();
                  widget.onChanged?.call(text);
                },
                textAlign: widget.textAlign,
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                obscureText: widget.obscureText,
                maxLength: widget.maxLength,
                autofillHints: widget.autofillHints,
                focusNode: _focusNode,
                textCapitalization: widget.textCapitalization,
              ),
            ),
          ],
        ),
        ErrorIndicatorWidget(
          error: error,
          showErrorIcon: widget.showErrorIcon,
        ),
      ],
    );
  }
}
