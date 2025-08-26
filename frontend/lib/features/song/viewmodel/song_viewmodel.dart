import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/core/utils/color.dart';
import 'package:music_app/features/auth/services/local_storage_service.dart';
import 'package:music_app/features/song/model/song_model.dart';
import 'package:music_app/features/song/services/song_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'song_viewmodel.g.dart';

@riverpod
class SongViewModel extends _$SongViewModel {
  late SongService _songService;
  late LocalStorageService _localStorageService;

  @override
  AsyncValue? build() {
    _songService = ref.watch(songServiceProvider);
    _localStorageService = ref.watch(localStorageServiceProvider);
    return null;
  }

  Future<SongModel?> uploadSong({
    required File audio,
    required File thumbnail,
    required String name,
    required String artist,
    required Color color,
  }) async {
    state = AsyncValue.loading();
    final token = _localStorageService.getToken() ?? "";

    final res = await _songService.uploadSong(
      thumbnail: thumbnail,
      audio: audio,
      name: name,
      artist: artist,
      color: rgbToHex(color),
      token: token,
    );

    late SongModel? data;

    res.fold(
      (error) {
        state = AsyncValue.error(error.message, StackTrace.current);
        data = null;
      },
      (result) {
        data = result.data;
        AsyncValue.data(result.data);
      },
    );

    return data;
  }
}
