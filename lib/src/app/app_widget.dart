import 'package:flutter/material.dart';
import 'package:utilidades/src/app/app_routes.dart';
import 'package:utilidades/src/views/firebase_login_view.dart';
import 'package:utilidades/src/views/login_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Utilidades",
      initialRoute: "/home",
      routes: {
        "/login": (context) => LoginView(),
        "/loginfirebase": (context) => const FirebaseLoginView(),
        ...generateRoutes(),
      },
    );
  }
}
