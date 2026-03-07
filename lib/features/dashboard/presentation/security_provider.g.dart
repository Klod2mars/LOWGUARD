// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SecurityStatus)
const securityStatusProvider = SecurityStatusProvider._();

final class SecurityStatusProvider
    extends $NotifierProvider<SecurityStatus, SecurityLevel> {
  const SecurityStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'securityStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$securityStatusHash();

  @$internal
  @override
  SecurityStatus create() => SecurityStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecurityLevel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecurityLevel>(value),
    );
  }
}

String _$securityStatusHash() => r'be3d6b92f1fe5928acb0bf99d7f385c723354c45';

abstract class _$SecurityStatus extends $Notifier<SecurityLevel> {
  SecurityLevel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SecurityLevel, SecurityLevel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SecurityLevel, SecurityLevel>,
              SecurityLevel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
