// ignore_for_file: non_constant_identifier_names

class SongModel {
  final int id;
  final String name;
  final String artist;
  final String color;
  final String audio_url;
  final String audio_public_id;
  final String thumbnail_url;
  final String thumbnail_public_id;

  SongModel({
    required this.id,
    required this.name,
    required this.artist,
    required this.color,
    required this.audio_url,
    required this.audio_public_id,
    required this.thumbnail_url,
    required this.thumbnail_public_id,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'] as int,
      name: json['name'] as String,
      artist: json['artist'] as String,
      color: json['color'] as String,
      audio_url: json['audio_url'] as String,
      audio_public_id: json['audio_public_id'] as String,
      thumbnail_url: json['thumbnail_url'] as String,
      thumbnail_public_id: json['thumbnail_public_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'color': color,
      'audio_url': audio_url,
      'audio_public_id': audio_public_id,
      'thumbnail_url': thumbnail_url,
      'thumbnail_public_id': thumbnail_public_id,
    };
  }

  SongModel copyWith({
    int? id,
    String? name,
    String? artist,
    String? color,
    String? audio_url,
    String? audio_public_id,
    String? thumbnail_url,
    String? thumbnail_public_id,
  }) {
    return SongModel(
      id: id ?? this.id,
      name: name ?? this.name,
      artist: artist ?? this.artist,
      color: color ?? this.color,
      audio_url: audio_url ?? this.audio_url,
      audio_public_id: audio_public_id ?? this.audio_public_id,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      thumbnail_public_id: thumbnail_public_id ?? this.thumbnail_public_id,
    );
  }
}
