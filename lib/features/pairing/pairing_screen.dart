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
  final TextEditingController _ipController = TextEditingController();

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

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
                  debugPrint('Detected barcode: ${barcode.rawValue}');
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
                        itemBuilder: (context, index) {
                          final service = services[index];
                          final host = service.host;
                          return ListTile(
                            title: Text(service.name, style: const TextStyle(color: Colors.white)),
                            subtitle: Text(host ?? 'Resolving IP...', style: const TextStyle(color: Colors.white54)),
                            trailing: Icon(Icons.link, color: host != null ? Colors.blue : Colors.grey),
                            onTap: host == null ? null : () {
                              _ipController.text = host;
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected ${service.name}. Now scan QR code.')));
                            },
                          );
                        },
                      ),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, s) => Text('Error: $e', style: const TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(height: 12),
                  const Text('MANUAL CONNECTION:', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _ipController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'HOC IP (e.g. 192.168.1.50)',
                            hintStyle: TextStyle(color: Colors.white38),
                            isDense: true,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _isPairing ? null : () => _executePairing(_ipController.text.trim(), 'manual'),
                        icon: const Icon(Icons.send, color: Colors.blue),
                      ),
                    ],
                  ),
                  if (_isPairing) ...[
                    const SizedBox(height: 12),
                    const LinearProgressIndicator(color: Colors.green),
                    const Text('Pairing in progress...', style: TextStyle(color: Colors.green, fontSize: 12)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleScannedData(String data) async {
    debugPrint('Processing scanned data: $data');
    // Expected format: lowguard:pair?token=TOKEN&host=HOST
    if (!data.startsWith('lowguard:pair')) {
      debugPrint('Invalid format: prefix mismatch');
      return;
    }
    
    debugPrint('Valid format detected, starting pairing process...');
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
    if (host.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Starting manual pairing...')));
    // In manual mode without QR, we might need to ask for token. 
    // But for now, let's assume the user enters host and then scans OR we use a default/empty token if the server allows it for testing.
    // Actually, pairing ALWAYS needs a token from the HOC screen.
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please scan the QR code to provide the pairing token.')));
  }

  Future<void> _executePairing(String host, String token) async {
    if (host.isEmpty) return;
    final repo = ref.read(pairingRepositoryProvider);
    final baseUrl = 'http://$host:8000';
    debugPrint('Executing pairing with $baseUrl...');
    
    setState(() => _isPairing = true);
    try {
      final deviceId = 'mobile_${DateTime.now().millisecondsSinceEpoch}';
      debugPrint('Confirming pairing for device $deviceId...');
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
