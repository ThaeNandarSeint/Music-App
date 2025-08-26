import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app/core/models/error_response.dart';
import 'package:music_app/features/song/model/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'song_service.g.dart';

@riverpod
SongService songService(Ref ref) => SongService();

class SongService {
  Future<Either<ErrorResponse, dynamic>> uploadSong({
    required File thumbnail,
    required File audio,
    required String name,
    required String artist,
    required String color,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${dotenv.env['API_URL']}/songs'),
      );

      request
        ..files.addAll([
          await http.MultipartFile.fromPath('audio', audio.path),
          await http.MultipartFile.fromPath('thumbnail', thumbnail.path),
        ])
        ..fields.addAll({"artist": artist, "name": name, "color": color})
        ..headers.addAll({'Authorization': 'Bearer $token'});

      final response = await http.Response.fromStream(await request.send());
      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return Left(ErrorResponse(message: data['message'] ?? 'Login failed'));
      }
      return Right(SongModel.fromJson(data));
    } catch (e) {
      return Left(ErrorResponse(message: 'Uploading Song failed'));
    }
  }
}
