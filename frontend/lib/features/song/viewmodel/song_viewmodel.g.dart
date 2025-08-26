// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllSongsHash() => r'18279162313b9c93925cabe3a00c024726fa8f76';

/// See also [getAllSongs].
@ProviderFor(getAllSongs)
final getAllSongsProvider =
    AutoDisposeFutureProvider<GetSongsResponse?>.internal(
      getAllSongs,
      name: r'getAllSongsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getAllSongsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAllSongsRef = AutoDisposeFutureProviderRef<GetSongsResponse?>;
String _$songViewModelHash() => r'81dad32a15dfe3e8679410b145fe78e14679a940';

/// See also [SongViewModel].
@ProviderFor(SongViewModel)
final songViewModelProvider =
    AutoDisposeNotifierProvider<SongViewModel, AsyncValue?>.internal(
      SongViewModel.new,
      name: r'songViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$songViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SongViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
