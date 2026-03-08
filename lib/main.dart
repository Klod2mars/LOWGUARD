import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lowguard/core/navigation/router.dart';
import 'package:lowguard/shared/theme/war_room_theme.dart';

void main() {
  runApp(const ProviderScope(child: LowGuardApp()));
}

class LowGuardApp extends StatelessWidget {
  const LowGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LOWGUARD',
      theme: WarRoomTheme.darkTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
