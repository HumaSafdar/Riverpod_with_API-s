import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_apiiiiiiiiiiiiiiiiiiiiiiiii/album_state.dart';
import 'package:riverpod_apiiiiiiiiiiiiiiiiiiiiiiiii/album_state_notfier.dart';

final AlbumStateProvider =
    StateNotifierProvider<AlbumStateNotifier, AlbumState>((ref) {
  return AlbumStateNotifier();
});
