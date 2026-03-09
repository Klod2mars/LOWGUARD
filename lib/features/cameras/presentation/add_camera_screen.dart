import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lowguard/features/cameras/data/camera_repository.dart';

class AddCameraScreen extends ConsumerStatefulWidget {
  const AddCameraScreen({super.key});

  @override
  ConsumerState<AddCameraScreen> createState() => _AddCameraScreenState();
}

class _AddCameraScreenState extends ConsumerState<AddCameraScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _urlController = TextEditingController();
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  String _type = 'RTSP';
  bool _isScanning = false;
  String? _previewUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ADD CAMERA')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildScanSection(),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              Text('MANUAL ADDITION', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'Camera ID (unique)'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _type,
                items: ['RTSP', 'ONVIF'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (v) => setState(() => _type = v!),
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(labelText: 'Source URL (rtsp://...)'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: TextFormField(controller: _userController, decoration: const InputDecoration(labelText: 'Username'))),
                  const SizedBox(width: 16),
                  Expanded(child: TextFormField(controller: _passController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true)),
                ],
              ),
              const SizedBox(height: 24),
              if (_previewUrl != null) ...[
                const Text('PREVIEW:'),
                const SizedBox(height: 8),
                Container(
                  height: 200,
                  decoration: BoxDecoration(border: Border.all(color: Colors.redAccent)),
                  child: Image.network(_previewUrl!, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Center(child: Text('Preview unavailable'))),
                ),
                const SizedBox(height: 24),
              ],
              ElevatedButton(
                onPressed: _testAndSave,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
                child: const Text('TEST & SAVE'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScanSection() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _startScan,
          icon: Icon(_isScanning ? Icons.hourglass_empty : Icons.search),
          label: Text(_isScanning ? 'SCANNING LAN...' : 'SCAN NETWORK (ONVIF/mDNS)'),
        ),
        if (_isScanning) const LinearProgressIndicator(),
      ],
    );
  }

  void _startScan() {
    setState(() => _isScanning = true);
    // Placeholder for discovery logic
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isScanning = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No devices found automatically. Use manual entry.')));
    });
  }

  void _testAndSave() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(cameraRepositoryProvider);
    final cam = Camera(
      id: _idController.text,
      type: _type,
      sourceUrl: _urlController.text,
      username: _userController.text,
      password: _passController.text,
      status: 'OFFLINE',
      meta: {},
    );

    try {
      await repo.registerCamera(cam);
      setState(() => _previewUrl = repo.getSnapshotUrl(cam.id));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Camera registered!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
