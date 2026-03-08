import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lowguard/features/dashboard/presentation/dashboard_page.dart';

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
  ],
);
