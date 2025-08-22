import 'package:music_app/core/providers/current_user_notifier.dart';
import 'package:music_app/features/auth/model/auth_response.dart';
import 'package:music_app/features/auth/services/auth_service.dart';
import 'package:music_app/features/auth/services/local_storage_service.dart';
import 'package:music_app/features/user/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late AuthService _authService;
  late LocalStorageService _localStorageService;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<AuthResponse>? build() {
    _authService = ref.watch(authServiceProvider);
    _localStorageService = ref.watch(localStorageServiceProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPreferences() async {
    await _localStorageService.init();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authService.register(
      name: name,
      email: email,
      password: password,
    );

    res.fold(
      (error) {
        state = AsyncValue.error(error.message, StackTrace.current);
      },
      (data) {
        state = AsyncValue.data(data);
        _localStorageService.setToken(data.token);
        _currentUserNotifier.addUser(data.user);
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    final res = await _authService.login(email: email, password: password);

    res.fold(
      (error) {
        state = AsyncValue.error(error.message, StackTrace.current);
      },
      (data) {
        state = AsyncValue.data(data);
        _localStorageService.setToken(data.token);
        _currentUserNotifier.addUser(data.user);
      },
    );
  }

  Future<UserModel?> getCurrentUser() async {
    state = const AsyncValue.loading();
    final token = _localStorageService.getToken();
    final res = await _authService.getCurrentUser(token ?? '');
    late UserModel? user;

    res.fold(
      (error) {
        state = AsyncValue.error(error.message, StackTrace.current);
        user = null;
      },
      (data) {
        user = data.user;
        _currentUserNotifier.addUser(data.user);
      },
    );

    return user;
  }
}
