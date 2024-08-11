// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCropsHash() => r'497c627078325fcd9e2c178c047ee1780da2bbdd';

/// See also [getCrops].
@ProviderFor(getCrops)
final getCropsProvider = FutureProvider<(String?, List<Crop>?)>.internal(
  getCrops,
  name: r'getCropsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getCropsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCropsRef = FutureProviderRef<(String?, List<Crop>?)>;
String _$getCropAdviceHash() => r'81c95ef4fe45efe5119c52c2f30ace069cc9bfae';

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

/// See also [getCropAdvice].
@ProviderFor(getCropAdvice)
const getCropAdviceProvider = GetCropAdviceFamily();

/// See also [getCropAdvice].
class GetCropAdviceFamily extends Family<AsyncValue<(String?, CropAdvice?)>> {
  /// See also [getCropAdvice].
  const GetCropAdviceFamily();

  /// See also [getCropAdvice].
  GetCropAdviceProvider call(
    int cropId,
    String date,
  ) {
    return GetCropAdviceProvider(
      cropId,
      date,
    );
  }

  @override
  GetCropAdviceProvider getProviderOverride(
    covariant GetCropAdviceProvider provider,
  ) {
    return call(
      provider.cropId,
      provider.date,
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
  String? get name => r'getCropAdviceProvider';
}

/// See also [getCropAdvice].
class GetCropAdviceProvider extends FutureProvider<(String?, CropAdvice?)> {
  /// See also [getCropAdvice].
  GetCropAdviceProvider(
    int cropId,
    String date,
  ) : this._internal(
          (ref) => getCropAdvice(
            ref as GetCropAdviceRef,
            cropId,
            date,
          ),
          from: getCropAdviceProvider,
          name: r'getCropAdviceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCropAdviceHash,
          dependencies: GetCropAdviceFamily._dependencies,
          allTransitiveDependencies:
              GetCropAdviceFamily._allTransitiveDependencies,
          cropId: cropId,
          date: date,
        );

  GetCropAdviceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cropId,
    required this.date,
  }) : super.internal();

  final int cropId;
  final String date;

  @override
  Override overrideWith(
    FutureOr<(String?, CropAdvice?)> Function(GetCropAdviceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCropAdviceProvider._internal(
        (ref) => create(ref as GetCropAdviceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cropId: cropId,
        date: date,
      ),
    );
  }

  @override
  FutureProviderElement<(String?, CropAdvice?)> createElement() {
    return _GetCropAdviceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCropAdviceProvider &&
        other.cropId == cropId &&
        other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cropId.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCropAdviceRef on FutureProviderRef<(String?, CropAdvice?)> {
  /// The parameter `cropId` of this provider.
  int get cropId;

  /// The parameter `date` of this provider.
  String get date;
}

class _GetCropAdviceProviderElement
    extends FutureProviderElement<(String?, CropAdvice?)>
    with GetCropAdviceRef {
  _GetCropAdviceProviderElement(super.provider);

  @override
  int get cropId => (origin as GetCropAdviceProvider).cropId;
  @override
  String get date => (origin as GetCropAdviceProvider).date;
}

String _$getCropDiseaseDiagnosisHash() =>
    r'cf5788a8d1165504df8998fe4848b16ae2658505';

/// See also [getCropDiseaseDiagnosis].
@ProviderFor(getCropDiseaseDiagnosis)
const getCropDiseaseDiagnosisProvider = GetCropDiseaseDiagnosisFamily();

/// See also [getCropDiseaseDiagnosis].
class GetCropDiseaseDiagnosisFamily
    extends Family<AsyncValue<(String?, CropDisease?)>> {
  /// See also [getCropDiseaseDiagnosis].
  const GetCropDiseaseDiagnosisFamily();

  /// See also [getCropDiseaseDiagnosis].
  GetCropDiseaseDiagnosisProvider call(
    int cropId,
    String imagePath,
  ) {
    return GetCropDiseaseDiagnosisProvider(
      cropId,
      imagePath,
    );
  }

  @override
  GetCropDiseaseDiagnosisProvider getProviderOverride(
    covariant GetCropDiseaseDiagnosisProvider provider,
  ) {
    return call(
      provider.cropId,
      provider.imagePath,
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
  String? get name => r'getCropDiseaseDiagnosisProvider';
}

/// See also [getCropDiseaseDiagnosis].
class GetCropDiseaseDiagnosisProvider
    extends AutoDisposeFutureProvider<(String?, CropDisease?)> {
  /// See also [getCropDiseaseDiagnosis].
  GetCropDiseaseDiagnosisProvider(
    int cropId,
    String imagePath,
  ) : this._internal(
          (ref) => getCropDiseaseDiagnosis(
            ref as GetCropDiseaseDiagnosisRef,
            cropId,
            imagePath,
          ),
          from: getCropDiseaseDiagnosisProvider,
          name: r'getCropDiseaseDiagnosisProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCropDiseaseDiagnosisHash,
          dependencies: GetCropDiseaseDiagnosisFamily._dependencies,
          allTransitiveDependencies:
              GetCropDiseaseDiagnosisFamily._allTransitiveDependencies,
          cropId: cropId,
          imagePath: imagePath,
        );

  GetCropDiseaseDiagnosisProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cropId,
    required this.imagePath,
  }) : super.internal();

  final int cropId;
  final String imagePath;

  @override
  Override overrideWith(
    FutureOr<(String?, CropDisease?)> Function(
            GetCropDiseaseDiagnosisRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCropDiseaseDiagnosisProvider._internal(
        (ref) => create(ref as GetCropDiseaseDiagnosisRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cropId: cropId,
        imagePath: imagePath,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<(String?, CropDisease?)> createElement() {
    return _GetCropDiseaseDiagnosisProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCropDiseaseDiagnosisProvider &&
        other.cropId == cropId &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cropId.hashCode);
    hash = _SystemHash.combine(hash, imagePath.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCropDiseaseDiagnosisRef
    on AutoDisposeFutureProviderRef<(String?, CropDisease?)> {
  /// The parameter `cropId` of this provider.
  int get cropId;

  /// The parameter `imagePath` of this provider.
  String get imagePath;
}

class _GetCropDiseaseDiagnosisProviderElement
    extends AutoDisposeFutureProviderElement<(String?, CropDisease?)>
    with GetCropDiseaseDiagnosisRef {
  _GetCropDiseaseDiagnosisProviderElement(super.provider);

  @override
  int get cropId => (origin as GetCropDiseaseDiagnosisProvider).cropId;
  @override
  String get imagePath => (origin as GetCropDiseaseDiagnosisProvider).imagePath;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
