import 'package:music_app/features/song/model/song_model.dart';

class GetSongsResponse {
  final int count;
  final List<SongModel> data;

  GetSongsResponse({required this.count, required this.data});

  factory GetSongsResponse.fromJson(Map<String, dynamic> json) {
    return GetSongsResponse(
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => SongModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'data': data.map((e) => e.toJson()).toList()};
  }
}
