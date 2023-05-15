part of 'bottom_sheet.dart';

class _BottomSheetScrollNotification extends Notification
    with ViewportNotificationMixin {
  _BottomSheetScrollNotification({
    required this.extent,
    required this.initialExtent,
    required this.context,
  });

  final double initialExtent;
  final double extent;
  final BuildContext context;
}

class _BottomSheetScrollController extends ScrollController {
  _BottomSheetScrollController({
    required this.extent,
    double initialScrollOffset = 0.0,
  }) : super(initialScrollOffset: initialScrollOffset);

  _BottomSheetExtent extent;

  @override
  _BottomSheetScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) =>
      _BottomSheetScrollPosition(
        physics: physics,
        context: context,
        oldPosition: oldPosition,
        getExtent: () => extent,
      );

  @override
  _BottomSheetScrollPosition get position =>
      super.position as _BottomSheetScrollPosition;
}

class _BottomSheetScrollPosition extends ScrollPositionWithSingleContext {
  _BottomSheetScrollPosition({
    required this.getExtent,
    required ScrollPhysics physics,
    required ScrollContext context,
    double initialPixels = 0,
    bool keepScrollOffset = true,
    ScrollPosition? oldPosition,
  }) : super(
          physics: physics,
          context: context,
          initialPixels: initialPixels,
          keepScrollOffset: keepScrollOffset,
          oldPosition: oldPosition,
        );

  VoidCallback? _dragCancelCallback;
  VoidCallback? _ballisticCancelCallback;
  final _BottomSheetExtent Function() getExtent;

  bool get shouldListScroll => pixels > 0.0;

  _BottomSheetExtent get extent => getExtent();

  @override
  void beginActivity(ScrollActivity? newActivity) {
    _ballisticCancelCallback?.call();
    super.beginActivity(newActivity);
  }

  @override
  bool applyContentDimensions(double minScrollExtent, double maxScrollExtent) {
    return super.applyContentDimensions(
      minScrollExtent - extent.additionalMinSize,
      maxScrollExtent + extent.additionalMaxSize,
    );
  }

  @override
  void applyUserOffset(double delta) {
    if (!shouldListScroll &&
        (!(extent.isAtMin || extent.isAtMax) ||
            (extent.isAtMin && delta < 0) ||
            (extent.isAtMax && delta > 0))) {
      extent.addPixelDelta(-delta, context.notificationContext!);
    } else {
      super.applyUserOffset(delta);
    }
  }

  @override
  void dispose() {
    _ballisticCancelCallback?.call();
    super.dispose();
  }

  @override
  void goBallistic(double velocity) {
    if ((velocity < 0 && shouldListScroll) ||
        (velocity > 0 && extent.isAtMax)) {
      super.goBallistic(velocity);
      return;
    }

    _dragCancelCallback?.call();
    _dragCancelCallback = null;

    late final simulation = ClampingScrollSimulation(
      position: extent.currentPixels,
      velocity: velocity,
      tolerance: physics.tolerance,
    );
    final ballisticController = AnimationController.unbounded(
      vsync: context.vsync,
    );

    _ballisticCancelCallback = ballisticController.stop;
    var lastPosition = extent.currentPixels;

    void tick() {
      final delta = ballisticController.value - lastPosition;
      lastPosition = ballisticController.value;
      extent.addPixelDelta(delta, context.notificationContext!);

      if ((velocity > 0 && extent.isAtMax) ||
          (velocity < 0 && extent.isAtMin)) {
        super.goBallistic(
          ballisticController.velocity +
              (physics.tolerance.velocity * ballisticController.velocity.sign),
        );
        ballisticController.stop();
      } else if (ballisticController.isCompleted) {
        super.goBallistic(0.0);
      }
    }

    ballisticController
      ..addListener(tick)
      ..animateWith(simulation).whenCompleteOrCancel(() {
        _ballisticCancelCallback = null;
        ballisticController.dispose();
      });
  }

  @override
  Drag drag(DragStartDetails details, VoidCallback dragCancelCallback) {
    _dragCancelCallback = dragCancelCallback;
    return super.drag(details, dragCancelCallback);
  }
}
