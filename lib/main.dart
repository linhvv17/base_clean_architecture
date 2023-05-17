import 'dart:async';

import 'package:base_clean_architecture/app.dart';
import 'package:base_clean_architecture/core/configs/app_configs.dart';
import 'package:base_clean_architecture/dependencies_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: AppConfigs.url,
    anonKey: AppConfigs.anonKey,
  );

  // Get a reference your Supabase client
  final supabase = Supabase.instance.client;

  // //login
  // final AuthResponse res = await supabase.auth.signInWithPassword(
  //   email: 'example@email.com',
  //   password: 'example-password',
  // );
  // final id = res.user?.id;

  //Register Service locator
  await serviceLocator();

  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(
      () => SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown
          ]).then((_) async {
            runApp(App());
          }),
      (error, stack) {});
}
