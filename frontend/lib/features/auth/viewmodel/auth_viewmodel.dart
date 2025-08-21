import 'package:music_app/features/auth/model/auth_response.dart';
import 'package:music_app/features/auth/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late AuthService _authService;

  @override
  AsyncValue<AuthResponse>? build() {
    _authService = ref.watch(authServiceProvider);
    return null;
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
      },
    );
  }
}
