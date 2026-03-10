import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class DiscoveryService {
  BonsoirDiscovery? _discovery;
  final String _type = '_lowguard._tcp';

  Stream<List<BonsoirService>> discover() async* {
    _discovery = BonsoirDiscovery(type: _type);
    await _discovery!.initialize();
    await _discovery!.start();

    final List<BonsoirService> services = [];
    yield services;

    await for (final event in _discovery!.eventStream!) {
      if (event is BonsoirDiscoveryServiceFoundEvent) {
        final service = event.service;
        if (!services.any((s) => s.name == service.name)) {
          services.add(service);
          yield List.from(services);
        }
      } else if (event is BonsoirDiscoveryServiceResolvedEvent) {
        final service = event.service;
        final index = services.indexWhere((s) => s.name == service.name);
        if (index != -1) {
          services[index] = service;
        } else {
          services.add(service);
        }
        yield List.from(services);
      } else if (event is BonsoirDiscoveryServiceLostEvent) {
        services.removeWhere((s) => s.name == event.service.name);
        yield List.from(services);
      }
    }
  }

  void stop() {
    _discovery?.stop();
  }
}

final discoveryServiceProvider = Provider((ref) => DiscoveryService());

final discoveredServicesProvider = StreamProvider<List<BonsoirService>>((ref) {
  final service = ref.watch(discoveryServiceProvider);
  return service.discover();
});
