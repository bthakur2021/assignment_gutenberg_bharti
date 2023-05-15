import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/margin.dart';
import '../providers/theme_provider.dart';
import '../providers/utils/provider_utility.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    required this.title,
    this.height,
    this.width = double.infinity,
    this.type = ButtonType.blue,
    this.iconPath,
    this.trailingIconPath,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.isDisabled = false,
    this.alignment,
    this.avoidOnPressLock = false,
    this.coloredImage = true,
    Key? key,
  })  : assert(
          type != ButtonType.textTertiaryWithSuffix || prefixIcon != null && suffixIcon != null,
        ),
        super(key: key);

  const ButtonWidget.icon({
    required this.iconPath,
    this.title = '',
    this.height,
    this.width = double.infinity,
    this.type = ButtonType.icon,
    this.trailingIconPath,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.isDisabled = false,
    this.alignment,
    this.avoidOnPressLock = false,
    this.coloredImage = true,
    Key? key,
  }) : super(key: key);

  final String title;
  final double? height;
  final double width;
  final ButtonType type;
  final String? iconPath;
  final String? trailingIconPath;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final AlignmentGeometry? alignment;
  final bool avoidOnPressLock;
  final bool coloredImage;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _isPressed = false;

  Future<void> onPressed() async {
    if (!isPressed) {
      isPressed = true;
      if (widget.onPressed is Future Function()) {
        await (widget.onPressed! as Future Function()).call();
      } else {
        widget.onPressed?.call();
      }
      isPressed = false;
    }
  }

  bool get isPressed => _isPressed;

  set isPressed(bool isPressed) {
    if (!widget.avoidOnPressLock) {
      setState(() => _isPressed = isPressed);
    }
  }

  bool get isShowIcon => widget.iconPath != null;

  bool get isShowTrailingIcon => widget.trailingIconPath != null;

  bool get isDisable => widget.isDisabled || widget.onPressed == null || isPressed;

  ButtonStyle? _buttonStyle(ThemeProvider theme) {
    ButtonStyle? style;

    switch (widget.type) {
      case ButtonType.icon:
      case ButtonType.blue:
        style = theme.buttonMain;
        break;
      case ButtonType.secondaryWithIcon:
        break;
      case ButtonType.textTertiary:
      case ButtonType.textTertiaryWithSuffix:
        break;
      case ButtonType.hollow:
        break;
      case ButtonType.red:
        break;
    }

    return style?.copyWith(
      alignment: widget.alignment,
      minimumSize: MaterialStateProperty.all(
        Size(widthOfButton ?? 0, heightOfButton),
      ),
      fixedSize: MaterialStateProperty.all(
        Size(widthOfButton ?? double.infinity, heightOfButton),
      ),
      maximumSize: MaterialStateProperty.all(
        Size.fromHeight(heightOfButton),
      ),
      textStyle: style.textStyle,
    );
  }

  Color _colorIcon(ThemeProvider theme) {
    if (isDisable) {
      return Colors.white;
    }

    switch (widget.type) {
      case ButtonType.blue:
      case ButtonType.secondaryWithIcon:
        return theme.themeColorViolet;
      case ButtonType.textTertiary:
      case ButtonType.textTertiaryWithSuffix:
        return theme.themeColorViolet;
      case ButtonType.hollow:
        return theme.textColor;
      case ButtonType.icon:
        return Colors.white;
      case ButtonType.red:
        return Colors.white;
    }
  }

  double get heightOfButton {
    switch (widget.type) {
      case ButtonType.icon:
        return widget.height ?? 56.0;
      case ButtonType.blue:
      case ButtonType.red:
        return widget.height ?? 56.0;
      case ButtonType.textTertiary:
      case ButtonType.textTertiaryWithSuffix:
        return widget.height ?? 40.0;
      case ButtonType.secondaryWithIcon:
        return widget.height ?? 33.0;
      case ButtonType.hollow:
        return widget.height ?? 56.0;
    }
  }

  double? get widthOfButton {
    switch (widget.type) {
      case ButtonType.red:
      case ButtonType.blue:
      case ButtonType.icon:
      case ButtonType.secondaryWithIcon:
      case ButtonType.hollow:
      case ButtonType.textTertiary:
      case ButtonType.textTertiaryWithSuffix:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightOfButton,
      child: Consumer(
        builder: (context, ref, child) {
          final theme = ref.watch(themeProvider);
          switch (widget.type) {
            case ButtonType.red:
            case ButtonType.blue:
              return _getElevatedButton(theme);
            case ButtonType.secondaryWithIcon:
              return _getSecondaryIconButton(theme);
            case ButtonType.textTertiary:
              return _getTertiaryIconButton(theme);
            case ButtonType.textTertiaryWithSuffix:
              return _getTertiaryIconWithSuffixButton(theme);
            case ButtonType.hollow:
              return _getHollowButton(theme);
            case ButtonType.icon:
              return _getIconButton(theme);
          }
        },
      ),
    );
  }

  Widget _getElevatedButton(ThemeProvider theme) {
    final style = _buttonStyle(theme);
    return ElevatedButton(
      style: style,
      onPressed: isDisable ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isShowIcon)
            getImage(
              iconPath: widget.iconPath!,
              height: 24,
              width: 24,
              theme: theme,
            ),
          if (isShowIcon) Margin.horizontal11,
          Text(
            widget.title,
          ),
        ],
      ),
    );
  }

  Widget _getSecondaryIconButton(ThemeProvider theme) {
    final style = _buttonStyle(theme);
    return ElevatedButton(
      style: style,
      onPressed: isDisable ? null : onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Text(
              widget.title,
            ),
          ),
          Margin.horizontal11,
        ],
      ),
    );
  }

  Widget _getTertiaryIconButton(ThemeProvider theme) {
    return TextButton(
      style: _buttonStyle(theme),
      onPressed: isDisable ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isShowIcon)
            getImage(
              height: 24,
              width: 24,
              iconPath: widget.iconPath!,
              theme: theme,
            ),
          if (isShowIcon) Margin.horizontal11,
          Text(
            widget.title,
          ),
          if (isShowTrailingIcon) ...[
            Margin.horizontal8,
            getImage(
              height: 16,
              width: 16,
              iconPath: widget.trailingIconPath!,
              theme: theme,
            ),
          ]
        ],
      ),
    );
  }

  Widget _getTertiaryIconWithSuffixButton(ThemeProvider theme) {
    return TextButton(
      style: _buttonStyle(theme),
      onPressed: isDisable ? null : onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.prefixIcon, size: 20),
          Margin.horizontal10,
          Text(
            widget.title,
          ),
          const Spacer(),
          Icon(widget.suffixIcon, size: 20),
        ],
      ),
    );
  }

  Widget _getHollowButton(ThemeProvider theme) {
    return ElevatedButton(
      style: _buttonStyle(theme),
      onPressed: isDisable ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isShowIcon)
            getImage(
              height: 22,
              width: 22,
              iconPath: widget.iconPath!,
              theme: theme,
            ),
          if (isShowIcon) Margin.horizontal16,
          Text(
            widget.title,
          ),
        ],
      ),
    );
  }

  Widget _getIconButton(ThemeProvider theme) {
    return ElevatedButton(
      style: _buttonStyle(theme),
      onPressed: isDisable ? null : onPressed,
      child: Image(
        image: AssetImage(
          widget.iconPath!,
        ),
        height: 22,
        width: 22,
        color: _colorIcon(theme),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget getImage({
    required double height,
    required double width,
    required String iconPath,
    required ThemeProvider theme,
  }) {
    return Image(
      image: AssetImage(iconPath),
      height: height,
      width: width,
      color: widget.coloredImage ? _colorIcon(theme) : null,
    );
  }
}

enum ButtonType {
  blue,
  secondaryWithIcon,
  textTertiary,
  textTertiaryWithSuffix,
  hollow,
  icon,
  red,
}
