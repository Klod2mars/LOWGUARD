import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lowguard/features/dashboard/presentation/dashboard_page.dart';
import 'package:lowguard/features/connectivity/presentation/settings_page.dart';
import 'package:lowguard/features/pairing/pairing_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const DashboardPage()),
    // Deep link example for intruders
    GoRoute(
      path: '/intruder/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return Scaffold(
          appBar: AppBar(title: Text('INTRUDER DETECTED: $id')),
          body: Center(child: Text('Viewing intruder $id details...')),
        );
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const ConnectivitySettingsPage(),
    ),
    GoRoute(
      path: '/pair',
      builder: (context, state) => const PairingScreen(),
    ),
  ],
);
