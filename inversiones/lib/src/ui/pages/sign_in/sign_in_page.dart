import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/sign_in/sign_in_controller.dart';
import 'package:inversiones/src/ui/pages/widgets/sign_in_password_input.dart';
import 'package:inversiones/src/ui/pages/widgets/sign_in_username_input.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.find<SignInController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: controller.formKey,
                child: const Column(
                  children: [
                    SignInUsernameInput(),
                    SizedBox(height: 15.0),
                    SignInPasswordInput(),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: controller.signIn,
                child: const Text('Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
