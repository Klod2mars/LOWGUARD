import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:lowguard/core/navigation/router.dart';
import 'package:lowguard/shared/theme/war_room_theme.dart';

import 'package:lowguard/services/foreground_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ForegroundService.init();
  runApp(const ProviderScope(child: LowGuardApp()));
}


class LowGuardApp extends StatelessWidget {
  const LowGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: MaterialApp.router(
        title: 'LOWGUARD',
        theme: WarRoomTheme.darkTheme,
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
