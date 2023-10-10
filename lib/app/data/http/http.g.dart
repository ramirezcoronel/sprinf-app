// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$httpHash() => r'07f36e3999b9ac9a9b39871b740c1d513d5dda4a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [http].
@ProviderFor(http)
const httpProvider = HttpFamily();

/// See also [http].
class HttpFamily extends Family<Http> {
  /// See also [http].
  const HttpFamily();

  /// See also [http].
  HttpProvider call({
    required String baseUrl,
    required String token,
  }) {
    return HttpProvider(
      baseUrl: baseUrl,
      token: token,
    );
  }

  @override
  HttpProvider getProviderOverride(
    covariant HttpProvider provider,
  ) {
    return call(
      baseUrl: provider.baseUrl,
      token: provider.token,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'httpProvider';
}

/// See also [http].
class HttpProvider extends AutoDisposeProvider<Http> {
  /// See also [http].
  HttpProvider({
    required String baseUrl,
    required String token,
  }) : this._internal(
          (ref) => http(
            ref as HttpRef,
            baseUrl: baseUrl,
            token: token,
          ),
          from: httpProvider,
          name: r'httpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$httpHash,
          dependencies: HttpFamily._dependencies,
          allTransitiveDependencies: HttpFamily._allTransitiveDependencies,
          baseUrl: baseUrl,
          token: token,
        );

  HttpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.baseUrl,
    required this.token,
  }) : super.internal();

  final String baseUrl;
  final String token;

  @override
  Override overrideWith(
    Http Function(HttpRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HttpProvider._internal(
        (ref) => create(ref as HttpRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        baseUrl: baseUrl,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Http> createElement() {
    return _HttpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HttpProvider &&
        other.baseUrl == baseUrl &&
        other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, baseUrl.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HttpRef on AutoDisposeProviderRef<Http> {
  /// The parameter `baseUrl` of this provider.
  String get baseUrl;

  /// The parameter `token` of this provider.
  String get token;
}

class _HttpProviderElement extends AutoDisposeProviderElement<Http>
    with HttpRef {
  _HttpProviderElement(super.provider);

  @override
  String get baseUrl => (origin as HttpProvider).baseUrl;
  @override
  String get token => (origin as HttpProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
