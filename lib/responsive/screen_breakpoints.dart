
/// Manually define screen resolution breakpoints
///
/// Overrides the defaults
class ScreenBreakpoints {
  final double? watch;
  final double? tablet;
  final double? desktop;

  ScreenBreakpoints(
      { this.desktop,  this.tablet, this.watch});

  @override
  String toString() {
    return "Desktop: $desktop, Tablet: $tablet, Watch: $watch";
  }
}
