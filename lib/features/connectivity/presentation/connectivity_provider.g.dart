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

String _$dioHash() => r'c62213bddb9aac89c0a19fe034ef243e2a285ba8';

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
    r'c9a0f68c72400f80caded123394f4d0ce8bc9f1d';

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

String _$systemStatusHash() => r'12f6e587077a74a16fb6aea2406c264cf0ae85c1';
