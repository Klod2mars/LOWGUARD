import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lowguard/features/cameras/data/camera_repository.dart';

class CameraList extends ConsumerWidget {
  const CameraList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camerasAsync = ref.watch(camerasProvider);

    return camerasAsync.when(
      data: (cameras) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cameras.length,
        itemBuilder: (context, index) {
          final camera = cameras[index];
          return Card(
            color: Colors.black26,
            child: ListTile(
              leading: Icon(
                Icons.videocam,
                color: camera.status == 'ONLINE' ? Colors.green : Colors.red,
              ),
              title: Text(camera.id, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              subtitle: Text(camera.type, style: const TextStyle(color: Colors.white70)),
              trailing: IconButton(
                icon: const Icon(Icons.preview, color: Colors.redAccent),
                onPressed: () => _showPreview(context, ref, camera),
              ),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  void _showPreview(BuildContext context, WidgetRef ref, Camera camera) {
    final repo = ref.read(cameraRepositoryProvider);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        title: Text('PREVIEW: ${camera.id}', style: const TextStyle(color: Colors.white)),
        content: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            repo.getSnapshotUrl(camera.id),
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => const Center(child: Text('Snapshot failed', style: TextStyle(color: Colors.red))),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CLOSE')),
        ],
      ),
    );
  }
}
