import 'dart:typed_data';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_company/controller/api.dart';
import 'package:task_company/controller/dataBase/storge_image.dart';
import 'package:task_company/model/university.dart';
import 'package:task_company/model/user.dart';

final userPictureProvider = AutoDisposeStateProvider<Uint8List?>((ref) {
  return null;
});
final chackvildateEmail = AutoDisposeStateProvider<bool>((ref) {
  return false;
});
final pageinPaginationUnversity = AutoDisposeStateProvider<int>((ref) {
  return ref.watch(selectedUnversity).length -
      ref.watch(selectedUnversity).length;
});
final filtterPageinPaginationUnversity =
    AutoDisposeStateProvider<List<University>>((ref) {
  return [];
});
final updatePagination = AutoDisposeStateProvider<bool>((ref) {
  return false;
});
final universitys = FutureProvider<List<University>>((ref) {
  return ref
      .watch(apiProvider)
      .fetchdata(country: ref.watch(selectedUnversity));
});
final apiProvider = Provider<ApiUnversity>((ref) => ApiUnversity());
// load image
final loadImageClass =
    Provider<StorgeImageFireBase>((ref) => StorgeImageFireBase());
final loadImage = FutureProvider<Uint8List?>((ref) {
  return ref.watch(loadImageClass).loadImage(
      imageUrl: ref.watch(userAccount) == null
          ? null
          : ref.watch(userAccount)!.imageUrl);
});
final selectedUnversity = StateProvider<String>((ref) {
  return 'Jordan';
});

final swiperController = StateProvider<SwiperController>((ref) {
  return SwiperController();
});
final userAccount = StateProvider<User?>((ref) {
  return null;
});
