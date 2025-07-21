import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utilidades/src/controllers/loginriver_controller.dart';
import 'package:utilidades/src/models/LoginState.dart';

final loginProvider = StateNotifierProvider<LoginRiverController, LoginState>(
  (ref) => LoginRiverController(),
);
