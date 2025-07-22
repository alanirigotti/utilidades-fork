import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utilidades/src/provider/login_provider.dart';

class LoginRiver extends ConsumerWidget {
  const LoginRiver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    final controller = ref.read(loginProvider.notifier);

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'E-mail'),
            onChanged: controller.updateEmail,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Senha'),
            onChanged: controller.updatePassword,
            obscureText: true,
          ),
          SizedBox(height: 20),
          state.isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                onPressed: controller.submitLogin,
                child: Text("Entrar"),
              ),
        ],
      ),
    );
  }
}
