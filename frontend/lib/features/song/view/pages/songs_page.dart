import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/providers/current_song_notifier.dart';
import 'package:music_app/core/theme/app_pallete.dart';
import 'package:music_app/core/widgets/loader.dart';
import 'package:music_app/features/song/viewmodel/song_viewmodel.dart';

class SongsPage extends ConsumerWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = ref.watch(getAllSongsProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Latest Today",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
          ),
          songs.when(
            data: (payload) {
              final data = payload?.data ?? [];

              return SizedBox(
                height: 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];

                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(currentSongNotifierProvider.notifier)
                            .updateSong(item);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(item.thumbnail_url),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 180,
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: Text(
                                item.artist,
                                style: const TextStyle(
                                  color: Pallete.subtitleText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            error: (error, st) {
              return Center(child: Text(error.toString()));
            },
            loading: () => const Loader(),
          ),
        ],
      ),
    );
  }
}
