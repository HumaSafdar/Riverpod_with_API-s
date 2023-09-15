import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_apiiiiiiiiiiiiiiiiiiiiiiiii/api_Provider.dart';

import 'album_state.dart';

class AlbumStateNotifier extends StateNotifier<AlbumState> {
  AlbumStateNotifier() : super(AlbumInitialState());
  final apiProvider = AlbumAPIProvider();
  void fetchAlbums() async {
    state = AlbumLoadingState();
    try {
      var albums = await apiProvider.fetchAlbums();
      state = AlbumLoadedState(albums: albums);
    } catch (e) {
      state = AlbumErrorState(errorMessage: e.toString());
    }
  }
}
