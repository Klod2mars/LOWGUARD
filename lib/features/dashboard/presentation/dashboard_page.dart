import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lowguard/shared/theme/war_room_theme.dart';
import 'package:lowguard/features/dashboard/presentation/security_provider.dart';
import 'package:lowguard/features/connectivity/presentation/connectivity_provider.dart';
import 'package:lowguard/core/navigation/router.dart';

import 'package:lowguard/features/connectivity/data/connection_manager.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final securityLevel = ref.watch(securityStatusProvider);
    final systemStatusAsync = ref.watch(systemStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LOWGUARD // WARROOM'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => goRouter.push('/settings'),
          ),
          _buildSecurityIndicator(securityLevel),
          _buildConnectionStatusBadge(ref),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: systemStatusAsync.when(
                data: (status) => GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildStatusCard(
                      'PERIMETER',
                      status.perimeter,
                      WarRoomTheme.neonGreen,
                    ),
                    _buildStatusCard('NETWORK', status.network, Colors.blue),
                    _buildStatusCard(
                      'BUTLER_AI',
                      status.butlerAi,
                      Colors.white,
                    ),
                    _buildStatusCard('SYSTEM', status.system, Colors.white),
                  ],
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: WarRoomTheme.neonGreen,
                  ),
                ),
                error: (err, stack) => Center(
                  child: Text(
                    'OFFLINE: $err',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLogTerminal(systemStatusAsync.hasValue),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityIndicator(securityLevel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        border: Border.all(color: securityLevel.color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          securityLevel.label,
          style: TextStyle(
            color: securityLevel.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String status, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Spacer(),
            Text(
              status,
              style: TextStyle(
                fontSize: 18,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogTerminal(bool isConnected) {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: WarRoomTheme.mutedGray),
      ),
      child: SingleChildScrollView(
        child: Text(
          isConnected
              ? '[SYSTEM] Booting LOWGUARD_WARROOM...\n[SYSTEM] Checksum verified.\n[SCAN] Searching for NAS on local network...\n[SCAN] NAS-01 found via mDNS.\n[READY] War Room operational.'
              : '[SYSTEM] RECONNECTING TO CORE...\n[ERROR] Connection refused.\n[SCAN] Retrying in 5s...',
          style: const TextStyle(color: WarRoomTheme.neonGreen, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildConnectionStatusBadge(WidgetRef ref) {
    final statusAsync = ref.watch(connectionStatusProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: statusAsync.when(
        data: (status) {
          Color color = WarRoomTheme.mutedGray;
          String label = 'UNKNOWN';
          switch (status) {
            case ConnectionStatus.connected:
              color = WarRoomTheme.neonGreen;
              label = 'LINK_UP';
              break;
            case ConnectionStatus.connecting:
              color = Colors.orange;
              label = 'SYNCING';
              break;
            case ConnectionStatus.disconnected:
              color = Colors.red;
              label = 'LINK_DOWN';
              break;
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withAlpha(25), // 0.1 * 255 approx 25
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const Icon(Icons.error, color: Colors.red, size: 16),
      ),
    );
  }
}
