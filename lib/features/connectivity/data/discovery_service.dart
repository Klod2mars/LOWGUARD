// lib/features/connectivity/data/discovery_service.dart
import 'dart:async';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscoveryService {
  static const String mdnsServiceName = '_lowguard._tcp';
  static const String lastIpKey = 'lowguard_last_ip';
  static const String autoConnectKey = 'lowguard_auto_connect';
  static const int defaultPort = 8000;

  final Duration defaultTimeout;

  DiscoveryService({this.defaultTimeout = const Duration(seconds: 5)});

  Future<String?> discoverOnce({Duration? timeout}) async {
    final t = timeout ?? defaultTimeout;
    final MDnsClient mdns = MDnsClient();
    try {
      await mdns.start();
      // Lookup PTR records for the service
      final ptrStream = mdns.lookup<PtrResourceRecord>(
        ResourceRecordQuery.serverPointer(mdnsServiceName),
      ).timeout(t);
      await for (final ptr in ptrStream) {
        // For each PTR, find SRV that matches the domain
        final srvStream = mdns.lookup<SrvResourceRecord>(
          ResourceRecordQuery.service(mdnsServiceName),
        ).timeout(t);
        await for (final srv in srvStream) {
          if (srv.target == ptr.domainName) {
            // Resolve A record
            final addrStream = mdns.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv4(srv.target),
            ).timeout(t);
            await for (final addr in addrStream) {
              final ip = addr.address.address;
              final port = srv.port;
              // save last ip (no port here - we store host)
              await _saveLastIp(ip);
              mdns.stop();
              return 'http://$ip:$port';
            }
          }
        }
      }
      mdns.stop();
    } catch (_) {
      try {
        mdns.stop();
      } catch (_) {}
    }
    // fallback to last known IP
    return _lastKnownBaseUrl();
  }

  Future<String?> _lastKnownBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final ip = prefs.getString(lastIpKey);
    if (ip == null) return null;
    return 'http://$ip:$defaultPort';
  }

  Future<void> _saveLastIp(String ip) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(lastIpKey, ip);
  }

  Future<void> saveManualIp(String ip) async {
    await _saveLastIp(ip);
  }

  Future<void> setAutoConnect(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(autoConnectKey, enabled);
  }

  Future<bool> getAutoConnect() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(autoConnectKey) ?? true;
  }
}
