import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:lowguard/features/pairing/pairing_repository.dart';
import 'package:lowguard/features/pairing/discovery_service.dart';
import 'package:go_router/go_router.dart';

class PairingScreen extends ConsumerStatefulWidget {
  const PairingScreen({super.key});

  @override
  ConsumerState<PairingScreen> createState() => _PairingScreenState();
}

class _PairingScreenState extends ConsumerState<PairingScreen> {
  bool _isPairing = false;

  @override
  Widget build(BuildContext context) {
    final discoveredServices = ref.watch(discoveredServicesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('PAIR DEVICE')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: MobileScanner(
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null && !_isPairing) {
                    _handleScannedData(barcode.rawValue!);
                  }
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black87,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('DISCOVERED HOCs:', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  discoveredServices.when(
                    data: (services) => Expanded(
                      child: ListView.builder(
                        itemCount: services.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(services[index].name, style: const TextStyle(color: Colors.white)),
                          subtitle: Text(services[index].host ?? 'Unknown IP', style: const TextStyle(color: Colors.white54)),
                          trailing: const Icon(Icons.link, color: Colors.blue),
                          onTap: () => _manualPair(services[index].host!),
                        ),
                      ),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, s) => Text('Error: $e', style: const TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleScannedData(String data) async {
    // Expected format: lowguard:pair?token=TOKEN&host=HOST
    if (!data.startsWith('lowguard:pair')) return;
    
    setState(() => _isPairing = true);
    final uri = Uri.parse(data.replaceFirst('lowguard:pair', 'http://placeholder'));
    final token = uri.queryParameters['token'];
    final host = uri.queryParameters['host'];

    if (token != null && host != null) {
      await _executePairing(host, token);
    } else {
      setState(() => _isPairing = false);
    }
  }

  void _manualPair(String host) {
    // In manual mode, we might ask for token or just scan
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Point camera to QR on HOC screen')));
  }

  Future<void> _executePairing(String host, String token) async {
    final repo = ref.read(pairingRepositoryProvider);
    final baseUrl = 'http://$host:8000';
    
    try {
      final deviceId = 'mobile_${DateTime.now().millisecondsSinceEpoch}';
      final result = await repo.confirmPairing(baseUrl, token, deviceId, 'Mobile App');
      
      final deviceKey = result['device_key'];
      await repo.saveDeviceKey(deviceId, deviceKey);
      await repo.saveDeviceId(deviceId); // Save the active ID
      await repo.saveBaseUrl(baseUrl);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pairing Successful!')));
        context.go('/'); // Back to dashboard
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pairing Failed: $e')));
        setState(() => _isPairing = false);
      }
    }
  }
}
