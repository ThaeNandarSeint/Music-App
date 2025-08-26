import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app/core/providers/current_user_notifier.dart';
import 'package:music_app/core/theme/theme.dart';
import 'package:music_app/features/auth/view/pages/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:music_app/features/home/view/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final container = ProviderContainer();

  await container.read(authViewmodelProvider.notifier).initSharedPreferences();

  await container.read(authViewmodelProvider.notifier).getCurrentUser();

  runApp(UncontrolledProviderScope(container: container, child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);

    return MaterialApp(
      title: 'Music App',
      theme: AppTheme.dartThemeMode,
      home: currentUser == null ? const LoginPage() : const HomePage(),
    );
  }
}
