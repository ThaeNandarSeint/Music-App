import 'package:flutter/material.dart';
import 'package:music_app/core/theme/app_pallete.dart';
import 'package:music_app/features/auth/view/widgets/auth_button.dart';
import 'package:music_app/features/auth/view/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              CustomTextField(hintText: 'Name', controller: nameController),
              const SizedBox(height: 15),
              CustomTextField(hintText: 'Email', controller: emailController),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: 'Password',
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 20),
              AuthButton(buttonText: "Sign Up", onTap: () {}),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: const [
                    TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                        color: Pallete.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
