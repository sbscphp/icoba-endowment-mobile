
import 'dart:ui';

extension OpacityExtension on Color {
  ///Adds opacity using alpha conversion
  ///[opacity] should be between 0.0 and 1.0
  Color withCustomOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0, 'Opacity must be between 0.0 and 1.0');
    return withAlpha((255 * opacity).toInt());
  }
}