import 'package:music_app/features/song/model/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:just_audio/just_audio.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? audioPlayer = AudioPlayer();

  @override
  SongModel? build() {
    return null;
  }

  void updateSong(SongModel data) async {
    audioPlayer = AudioPlayer();
    // await audioPlayer!.setUrl(data.audio_url);
    final audioSource = AudioSource.uri(Uri.parse(data.audio_url));
    await audioPlayer!.setAudioSource(audioSource);

    audioPlayer!.play();
    state = data;
  }
}
