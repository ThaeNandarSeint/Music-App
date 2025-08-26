import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/theme/app_pallete.dart';
import 'package:music_app/core/utils/toast.dart';
import 'package:music_app/core/widgets/loader.dart';
import 'package:music_app/features/auth/view/pages/register_page.dart';
import 'package:music_app/features/auth/view/widgets/auth_button.dart';
import 'package:music_app/core/widgets/custom_text_field.dart';
import 'package:music_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:music_app/features/home/view/pages/home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewmodelProvider.select((value) => value?.isLoading == true),
    );

    ref.listen(authViewmodelProvider, (_, next) {
      next?.when(
        data: (data) {
          showSnackBar(context, 'Login successful');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => const LoginPage()),
          );
        },
        error: (error, stackTrace) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Loader()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign In.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      hintText: 'Password',
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(height: 20),
                    AuthButton(
                      buttonText: "Sign In",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(authViewmodelProvider.notifier)
                              .login(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                          Navigator.pushAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const HomePage(),
                            ),
                            (_) => false,
                          );
                        } else {
                          showSnackBar(context, 'Please fill all fields');
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const RegisterPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: const [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Pallete.gradient2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
