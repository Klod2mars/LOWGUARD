import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class DiscoveryService {
  BonsoirDiscovery? _discovery;
  final String _type = '_lowguard._tcp';

  Stream<List<ResolvedBonsoirService>> discover() async* {
    _discovery = BonsoirDiscovery(type: _type);
    await _discovery!.ready;
    await _discovery!.start();

    final List<ResolvedBonsoirService> services = [];

    await for (final event in _discovery!.eventStream!) {
      if (event.type == BonsoirDiscoveryEventType.discoveryServiceResolved) {
        final service = event.service as ResolvedBonsoirService;
        if (!services.any((s) => s.name == service.name)) {
          services.add(service);
          yield List.from(services);
        }
      } else if (event.type == BonsoirDiscoveryEventType.discoveryServiceLost) {
        services.removeWhere((s) => s.name == event.service!.name);
        yield List.from(services);
      }
    }
  }

  void stop() {
    _discovery?.stop();
  }
}

final discoveryServiceProvider = Provider((ref) => DiscoveryService());

final discoveredServicesProvider = StreamProvider<List<ResolvedBonsoirService>>((ref) {
  final service = ref.watch(discoveryServiceProvider);
  return service.discover();
});
