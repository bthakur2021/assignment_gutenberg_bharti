import 'dart:math';
import 'dart:ui';

import 'package:boxy/boxy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';

part 'bottom_sheet_scroll.dart';
part 'modal_bottom_sheet.dart';

const double _minFlingVelocity = 700.0;
const double _closeProgressThreshold = 0.5;

class _BottomSheetWidget extends StatefulWidget {
  const _BottomSheetWidget({
    required this.builder,
    this.title,
    this.animationController,
    this.initialSize,
    this.maxSize = 0.75,
    this.minSize = 0,
    this.expand = false,
    this.useMaxSize = true,
    this.showCloseButton = true,
    this.onClose,
    this.topBarColor,
    this.borderRadius = const Radius.circular(10.0),
    this.onDragStart,
    this.onDragEnd,
    Key? key,
  })  : isFractionallySized = initialSize != null,
        super(key: key);

  final String? title;
  final ScrollableWidgetBuilder builder;
  final AnimationController? animationController;
  final double? initialSize;
  final double maxSize;
  final double minSize;
  final bool expand;
  final bool useMaxSize;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final Color? topBarColor;
  final Radius borderRadius;
  final BottomSheetDragStartHandler? onDragStart;
  final BottomSheetDragEndHandler? onDragEnd;

  final bool isFractionallySized;

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<_BottomSheetWidget> {
  late _BottomSheetScrollController _scrollController;
  late _BottomSheetExtent _extent;
  late double? _initialSize = widget.initialSize;
  late double _maxSize = widget.maxSize;
  late double _childSize;

  @override
  void initState() {
    super.initState();
    _extent = _BottomSheetExtent(
      minSize: widget.minSize,
      maxSize: _maxSize,
      initialSize: _initialSize ?? _maxSize,
      onSizeChanged: _setSize,
    );
    _scrollController = _BottomSheetScrollController(extent: _extent);
  }

  @override
  void didUpdateWidget(covariant _BottomSheetWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _replaceExtent();
  }

  void _setSize() => setState(() {});

  bool get _dismissUnderway =>
      widget.animationController!.status == AnimationStatus.reverse;

  void _handleDragStart(DragStartDetails details) =>
      widget.onDragStart?.call(details);

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_dismissUnderway) {
      widget.animationController!.value -= details.primaryDelta! / _childSize;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dismissUnderway) {
      return;
    }

    var isClosing = false;

    if (details.velocity.pixelsPerSecond.dy > _minFlingVelocity) {
      final flingVelocity = -details.velocity.pixelsPerSecond.dy / _childSize;
      if (widget.animationController!.value > 0.0) {
        widget.animationController!.fling(velocity: flingVelocity);
      }
      if (flingVelocity < 0.0) {
        isClosing = true;
      }
    } else if (widget.animationController!.value < _closeProgressThreshold) {
      if (widget.animationController!.value > 0.0) {
        widget.animationController!.fling(velocity: -1.0);
      }
      isClosing = true;
    } else {
      widget.animationController!.forward();
    }

    widget.onDragEnd?.call(details, isClosing: isClosing);

    if (isClosing) {
      widget.onClose?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<_BottomSheetScrollNotification>(
      onNotification: (notification) {
        if (notification.extent == widget.minSize) {
          widget.onClose?.call();
          _extent.dispose();
        }

        return false;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          Widget sheet = CustomBoxy(
            delegate: _BottomSheetDelegate(
              constraints: constraints,
              onLayout: (initialHeight) {
                _childSize = initialHeight;
                if (_initialSize == null) {
                  _initialSize = initialHeight / constraints.biggest.height;
                  if (widget.useMaxSize) {
                    _maxSize = _initialSize!;
                  }
                  _initialSize = min(_initialSize!, widget.maxSize);
                  _replaceExtent();
                }
              },
            ),
            children: [
              BoxyId(
                id: #topBar,
                child: Container(height: 1,),
                /*child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: widget.topBarColor,
                    borderRadius: BorderRadius.vertical(
                      top: widget.borderRadius,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 21),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: AppStyle.titleTextRegular16,
                        ),
                        if (widget.showCloseButton)
                          CustomCloseButton(onPressed: widget.onClose),
                      ],
                    ),
                  ),
                ),*/
              ),
              BoxyId(
                id: #content,
                child: widget.builder(context, _scrollController),
              ),
            ],
          );

          _extent.availablePixels = widget.maxSize * constraints.biggest.height;

          if (widget.isFractionallySized)
            sheet = FractionallySizedBox(
              heightFactor: _extent.currentSize,
              alignment: Alignment.bottomCenter,
              child: sheet,
            );

          if (widget.expand)
            sheet = SizedBox.expand(
              child: sheet,
            );

          return GestureDetector(
            onVerticalDragStart: _handleDragStart,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: sheet,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _extent.dispose();
    super.dispose();
  }

  void _replaceExtent() {
    _extent.dispose();
    _extent = _extent.copyWith(
      minSize: widget.minSize,
      maxSize: _maxSize,
      initialSize: _initialSize ?? _maxSize,
      onSizeChanged: _setSize,
    );

    _scrollController.extent = _extent;
  }
}

class _BottomSheetExtent {
  _BottomSheetExtent({
    required this.onSizeChanged,
    this.initialSize = 0,
    this.minSize = 0,
    this.maxSize = 1,
    ValueNotifier<double>? currentSize,
    bool? hasChanged,
  })  : assert(minSize >= 0),
        assert(maxSize <= 1),
        assert(minSize <= initialSize),
        assert(initialSize <= maxSize),
        _currentSize = (currentSize ?? ValueNotifier<double>(initialSize))
          ..addListener(onSizeChanged),
        availablePixels = double.infinity,
        hasChanged = hasChanged ?? false;

  final double minSize;
  final double maxSize;
  final double initialSize;
  final ValueNotifier<double> _currentSize;
  final VoidCallback onSizeChanged;
  double availablePixels;

  bool hasChanged;

  bool get isAtMin => minSize >= _currentSize.value;

  bool get isAtMax => maxSize <= _currentSize.value;

  set currentSize(double value) {
    hasChanged = true;
    _currentSize.value = value.clamp(minSize, maxSize);
  }

  double get currentSize => _currentSize.value;

  double get currentPixels => sizeToPixels(_currentSize.value);

  double get additionalMinSize => isAtMin ? 0.0 : 1.0;

  double get additionalMaxSize => isAtMax ? 0.0 : 1.0;

  void addPixelDelta(double delta, BuildContext context) {
    if (availablePixels == 0) {
      return;
    }

    updateSize(currentSize + pixelsToSize(delta), context);
  }

  void updateSize(double newSize, BuildContext context) {
    currentSize = newSize;
    _BottomSheetScrollNotification(
      extent: currentSize,
      initialExtent: initialSize,
      context: context,
    ).dispatch(context);
  }

  double pixelsToSize(double pixels) => pixels / availablePixels * maxSize;

  double sizeToPixels(double extent) => extent / availablePixels * maxSize;

  void dispose() => _currentSize.removeListener(onSizeChanged);

  _BottomSheetExtent copyWith({
    required double minSize,
    required double maxSize,
    required double initialSize,
    required VoidCallback onSizeChanged,
  }) {
    return _BottomSheetExtent(
      minSize: minSize,
      maxSize: maxSize,
      initialSize: initialSize,
      onSizeChanged: onSizeChanged,
      currentSize: ValueNotifier<double>(
        hasChanged ? _currentSize.value.clamp(minSize, maxSize) : initialSize,
      ),
      hasChanged: hasChanged,
    );
  }
}

class _BottomSheetDelegate extends BoxyDelegate {
  _BottomSheetDelegate({
    required this.constraints,
    required this.onLayout,
  });

  @override
  final BoxConstraints constraints;

  final void Function(double) onLayout;

  @override
  Size layout() {
    final topBar = getChild(#topBar);
    final content = getChild(#content);

    final topBarSize = topBar.layout(constraints);
    topBar.position(Offset.zero);

    final contentSize = content.layout(
      constraints.deflate(
        EdgeInsets.only(top: topBarSize.height),
      ),
    );
    content.position(Offset(0, topBarSize.height));

    final height = topBarSize.height + contentSize.height;

    onLayout(height);

    return Size(
      contentSize.width,
      height,
    );
  }
}

extension BottomSheetContextExtension on BuildContext {
  Future<T?> showModalBottomSheetWidget<T>({
    required ScrollableWidgetBuilder bottomSheetChildBuilder,
    double minSize = 0.0,
    double? initialSize,
    double maxSize = 0.75,
    bool expand = false,
    bool useMaxSize = true,
    Color? topBarColor,
    Radius borderRadius = const Radius.circular(10.0),
    VoidCallback? onClose,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showCloseButton = true,
  }) async {
    final navigator = Navigator.of(this, rootNavigator: useRootNavigator);
    return navigator.push<T>(
      _ModalBottomSheetWidgetRoute(
        //title: title,
        builder: bottomSheetChildBuilder,
        minSize: minSize,
        initialSize: initialSize,
        maxSize: maxSize,
        expand: expand,
        useMaxSize: useMaxSize,
        color: topBarColor,
        borderRadius: borderRadius,
        onClose: onClose,
        capturedThemes:
            InheritedTheme.capture(from: this, to: navigator.context),
        isScrollControlled: isScrollControlled,
        barrierLabel: MaterialLocalizations.of(this).modalBarrierDismissLabel,
        isDismissible: isDismissible,
        modalBarrierColor: barrierColor,
        enableDrag: enableDrag,
        showCloseButton: showCloseButton,
      ),
    );
  }
}
