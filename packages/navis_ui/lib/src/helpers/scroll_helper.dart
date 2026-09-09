import 'package:material_ui/material_ui.dart';

extension BuildContextNx on BuildContext {
  void scrollToSelectedContent() {
    Future<void>.delayed(kThemeAnimationDuration).then((value) {
      Scrollable.ensureVisible(this, duration: kThemeAnimationDuration);
    });
  }
}
