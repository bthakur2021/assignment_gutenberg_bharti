import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import '../constants/app_style.dart';
import '../constants/margin.dart';

class ErrorIndicatorWidget extends StatelessWidget {
  const ErrorIndicatorWidget({
    required this.error,
    this.showErrorIcon = true,
    super.key,
  });

  final bool showErrorIcon;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (error != null && error!.isNotEmpty) ...[
          Margin.vertical4,
          Row(
            children: [
              if (showErrorIcon)
                const Icon(
                  Icons.info,
                  color: AppColor.errorRed,
                  size: 11,
                ),
              Margin.horizontal6,
              Flexible(child: Text(error!, style: AppStyle.errorText)),
            ],
          ),
        ],
      ],
    );
  }
}
