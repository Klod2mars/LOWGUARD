// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dio)
const dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'088d5c03610503c2407a8d7429b0e9f3ee76406f';

@ProviderFor(connectivityRepository)
const connectivityRepositoryProvider = ConnectivityRepositoryProvider._();

final class ConnectivityRepositoryProvider
    extends
        $FunctionalProvider<
          ConnectivityRepository,
          ConnectivityRepository,
          ConnectivityRepository
        >
    with $Provider<ConnectivityRepository> {
  const ConnectivityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityRepositoryHash();

  @$internal
  @override
  $ProviderElement<ConnectivityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConnectivityRepository create(Ref ref) {
    return connectivityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConnectivityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConnectivityRepository>(value),
    );
  }
}

String _$connectivityRepositoryHash() =>
    r'a829b49f9e0028f1f28d0c08dc8a127831171f87';

@ProviderFor(connectionStatus)
const connectionStatusProvider = ConnectionStatusProvider._();

final class ConnectionStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<ConnectionStatus>,
          ConnectionStatus,
          Stream<ConnectionStatus>
        >
    with $FutureModifier<ConnectionStatus>, $StreamProvider<ConnectionStatus> {
  const ConnectionStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectionStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectionStatusHash();

  @$internal
  @override
  $StreamProviderElement<ConnectionStatus> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ConnectionStatus> create(Ref ref) {
    return connectionStatus(ref);
  }
}

String _$connectionStatusHash() => r'4ab7191a38f82a7727fdf25dc78f63e1feb63a40';

@ProviderFor(systemStatus)
const systemStatusProvider = SystemStatusProvider._();

final class SystemStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<SystemStatus>,
          SystemStatus,
          FutureOr<SystemStatus>
        >
    with $FutureModifier<SystemStatus>, $FutureProvider<SystemStatus> {
  const SystemStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemStatusHash();

  @$internal
  @override
  $FutureProviderElement<SystemStatus> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SystemStatus> create(Ref ref) {
    return systemStatus(ref);
  }
}

String _$systemStatusHash() => r'df0a007c17135de7f73c4d8a650b64eaf569e54e';
