import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final userPictureProvider = AutoDisposeStateProvider<Uint8List?>((ref) {
  return null;
});
final chackvildateEmail = StateProvider<bool>((ref) {
  return false;
});
