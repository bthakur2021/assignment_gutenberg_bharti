part of 'bottom_sheet.dart';

const Curve _bottomSheetWidgetCurve = decelerateEasing;

class _ModalBottomSheetWidgetLayout extends SingleChildLayoutDelegate {
  _ModalBottomSheetWidgetLayout(this.progress, this.isScrollControlled);

  final double progress;
  final bool isScrollControlled;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) => Offset(0.0, size.height - childSize.height * progress);

  @override
  bool shouldRelayout(_ModalBottomSheetWidgetLayout oldDelegate) => progress != oldDelegate.progress;
}

class _ModalBottomSheetWidget extends StatefulHookConsumerWidget {
  const _ModalBottomSheetWidget({
    required this.builder,
    this.title,
    this.minSize = 0.0,
    this.initialSize,
    this.maxSize = 0.75,
    this.borderRadius = const Radius.circular(10.0),
    this.expand = false,
    this.useMaxSize = true,
    this.color,
    this.showCloseButton = true,
    this.onClose,
    this.route,
    this.isScrollControlled = false,
  });

  final _ModalBottomSheetWidgetRoute? route;
  final bool isScrollControlled;
  final String? title;
  final ScrollableWidgetBuilder builder;
  final double minSize;
  final double? initialSize;
  final double maxSize;
  final Radius borderRadius;
  final bool expand;
  final bool useMaxSize;
  final Color? color;
  final bool showCloseButton;
  final VoidCallback? onClose;

  @override
  ConsumerState<_ModalBottomSheetWidget> createState() => _ModalBottomSheetWidgetState();
}

class _ModalBottomSheetWidgetState extends ConsumerState<_ModalBottomSheetWidget> {
  late ThemeProvider _themeProvider;
  ParametricCurve<double> animationCurve = _bottomSheetWidgetCurve;

  void handleDragStart(DragStartDetails details) {
    animationCurve = Curves.linear;
  }

  void handleDragEnd(DragEndDetails details, {bool? isClosing}) {
    animationCurve = _BottomSheetWidgetSuspendedCurve(
      widget.route!.animation!.value,
      curve: _bottomSheetWidgetCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    _themeProvider = ref.watch(themeProvider);

    return AnimatedBuilder(
      animation: widget.route!.animation!,
      child: Material(
        borderRadius: BorderRadius.vertical(top: widget.borderRadius, bottom: widget.borderRadius),
        color: widget.color ?? _themeProvider.cardColor,
        child: _BottomSheetWidget(
          title: widget.title,
          builder: widget.builder,
          animationController: widget.route!._animationController,
          minSize: widget.minSize,
          initialSize: widget.initialSize,
          maxSize: widget.maxSize,
          borderRadius: widget.borderRadius,
          expand: widget.expand,
          topBarColor: widget.color ?? _themeProvider.cardColor,
          useMaxSize: widget.useMaxSize,
          onDragStart: handleDragStart,
          onDragEnd: handleDragEnd,
          showCloseButton: widget.showCloseButton,
          onClose: () {
            if (widget.route!.isCurrent) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      builder: (context, child) {
        final animationValue = animationCurve.transform(
          widget.route!.animation!.value,
        );

        return CustomSingleChildLayout(
          delegate: _ModalBottomSheetWidgetLayout(
            animationValue,
            widget.isScrollControlled,
          ),
          child: child,
        );
      },
    );
  }
}

class _ModalBottomSheetWidgetRoute<T> extends PopupRoute<T> {
  _ModalBottomSheetWidgetRoute({
    required this.capturedThemes,
    required this.isScrollControlled,
    required this.builder,
    this.title,
    this.barrierLabel,
    this.modalBarrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
    this.minSize = 0.0,
    this.initialSize,
    this.maxSize = 0.75,
    this.borderRadius = const Radius.circular(10.0),
    this.expand = false,
    this.useMaxSize = true,
    this.color,
    this.onClose,
    this.showCloseButton = true,
    RouteSettings? settings,
  }) : super(settings: settings);

  final CapturedThemes capturedThemes;
  final bool isScrollControlled;
  final bool isDismissible;
  final bool enableDrag;
  final Color? modalBarrierColor;
  final String? title;
  final ScrollableWidgetBuilder builder;
  final double minSize;
  final double? initialSize;
  final double maxSize;
  final Radius borderRadius;
  final bool expand;
  final bool useMaxSize;
  final Color? color;
  final bool showCloseButton;
  final VoidCallback? onClose;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => isDismissible;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => modalBarrierColor ?? Colors.black54;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    _animationController = BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  bool didPop(T? result) {
    onClose?.call();
    return super.didPop(result);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final Widget bottomSheet = Padding(
      //padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        bottom: false,
        child: _ModalBottomSheetWidget(
          route: this,
          title: title,
          builder: builder,
          minSize: minSize,
          initialSize: initialSize,
          maxSize: maxSize,
          borderRadius: borderRadius,
          expand: expand,
          color: color,
          showCloseButton: showCloseButton,
          onClose: onClose,
          isScrollControlled: isScrollControlled,
          useMaxSize: useMaxSize,
        ),
      ),
    );

    return capturedThemes.wrap(bottomSheet);
  }
}

class _BottomSheetWidgetSuspendedCurve extends ParametricCurve<double> {
  const _BottomSheetWidgetSuspendedCurve(
    this.startingPoint, {
    this.curve = Curves.easeOutCubic,
  });

  final double startingPoint;
  final Curve curve;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    assert(startingPoint >= 0.0 && startingPoint <= 1.0);

    if (t < startingPoint) {
      return t;
    }

    if (t == 1.0) {
      return t;
    }

    final curveProgress = (t - startingPoint) / (1 - startingPoint);
    final transformed = curve.transform(curveProgress);
    return lerpDouble(startingPoint, 1, transformed)!;
  }
}
