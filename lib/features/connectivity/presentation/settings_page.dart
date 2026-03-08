// lib/features/connectivity/presentation/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lowguard/features/connectivity/data/discovery_notifier.dart';

class ConnectivitySettingsPage extends ConsumerStatefulWidget {
  const ConnectivitySettingsPage({super.key});

  @override
  ConsumerState<ConnectivitySettingsPage> createState() => _ConnectivitySettingsPageState();
}

class _ConnectivitySettingsPageState extends ConsumerState<ConnectivitySettingsPage> {
  late final TextEditingController _controller;
  bool _autoConnect = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier = ref.read(discoveryProvider.notifier);
      final auto = await notifier.getAutoConnect();
      final last = await notifier.getLastKnownBaseUrl();
      if (!mounted) return;
      setState(() {
        _autoConnect = auto;
        if (last != null) {
          try {
            final uri = Uri.parse(last);
            _controller.text = uri.host;
          } catch (_) {
            _controller.text = last;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final discovery = ref.watch(discoveryProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Connectivity Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Current Backend Status', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Target URL: ${discovery ?? "Not discovered"}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Manual Configuration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Manual IP (ex: 192.168.1.180)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final ip = _controller.text.trim();
                  if (ip.isNotEmpty) {
                    await ref.read(discoveryProvider.notifier).setManualIp(ip);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Manual IP saved')),
                    );
                  }
                },
                child: const Text('Save manual IP'),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              title: const Text('Auto connect'),
              subtitle: const Text('Search for backend automatically on startup'),
              trailing: Switch(
                value: _autoConnect,
                onChanged: (v) async {
                  setState(() => _autoConnect = v);
                  await ref.read(discoveryProvider.notifier).setAutoConnect(v);
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      await ref.read(discoveryProvider.notifier).discoverNow();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Discovery started')),
                      );
                    },
                    child: const Text('Discover now'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      await ref.read(discoveryProvider.notifier).setManualIp('');
                      _controller.clear();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saved IP cleared')),
                      );
                    },
                    child: const Text('Clear saved IP'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
