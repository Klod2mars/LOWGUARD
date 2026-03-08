import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:lowguard/features/connectivity/data/connection_manager.dart';
import 'package:logger/logger.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  final _logger = Logger();
  
  @override
  Future<void> onStart(DateTime timestamp, Object? sendPort) async {
    _logger.i('Foreground Task Started');
    final baseUrl = await FlutterForegroundTask.getData<String>(key: 'baseUrl');
    if (baseUrl != null) {
      ConnectionManager().start(baseUrl);
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    // Periodic work
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    _logger.i('Foreground Task Destroyed');
    ConnectionManager().stop();
  }

  @override
  void onNotificationButtonPressed(String id) {
    if (id == 'stop') {
      FlutterForegroundTask.stopService();
    }
  }
}

class ForegroundService {
  static Future<void> init() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'lowguard_connectivity',
        channelName: 'LowGuard Connectivity Service',
        channelDescription: 'Maintains persistent connection to the backend',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.nothing(),
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  static Future<void> start(String baseUrl) async {
    await FlutterForegroundTask.saveData(key: 'baseUrl', value: baseUrl);

    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(
        notificationTitle: 'LOWGUARD Connected',
        notificationText: 'Persistent link active',
        notificationButtons: [
          const NotificationButton(id: 'stop', text: 'STOP'),
        ],
        callback: startCallback,
      );
    }
  }

  static Future<void> stop() async {
    await FlutterForegroundTask.stopService();
  }
}
