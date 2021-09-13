import 'package:flutter/gestures.dart';

void gestit(PointerDownEvent p) {
  ScaleGestureRecognizer scale = new ScaleGestureRecognizer();

  scale.addPointer(p);
}
