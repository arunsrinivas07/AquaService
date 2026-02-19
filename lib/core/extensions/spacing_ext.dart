// lib/core/extensions/spacing_ext.dart

import 'package:flutter/widgets.dart';

extension NumSpacing on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());

  EdgeInsets get padAll => EdgeInsets.all(toDouble());
  EdgeInsets get padH => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get padV => EdgeInsets.symmetric(vertical: toDouble());
}
