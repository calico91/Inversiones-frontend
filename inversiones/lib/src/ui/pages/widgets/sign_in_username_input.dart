import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/sign_in/sign_in_controller.dart';

class SignInUsernameInput extends StatelessWidget {
  const SignInUsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.find<SignInController>();
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Username',
      ),
      controller: controller.usernameController,
    );
  }
}
