import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractState<T> {
  final _subject = BehaviorSubject<T>();

  AbstractState() {
    if (getKey() != null) {
      SharedPreferences.getInstance().then((prefs) {
        String? value = prefs.getString(_serializationKey);
        if (value != null) {
          _subject.add(deserialize(value));
        }
        init();
      });
    } else {
      init();
    }
  }

  Stream<T> get stream => _subject.stream;

  T? get value => _subject.value;

  Future<T> getCurrentOrNextValue() {
    var completer = Completer<T>();
    final subscription = _subject.stream.listen(null);
    subscription.onData((result) {
      // Update onData after listening.
      completer.complete(result);
      subscription.cancel();
    });
    subscription.onError((error) {
      completer.completeError(error);
      subscription.cancel();
    });

    return completer.future;
  }

  Future<bool> setValue(T model) {
    _subject.add(model);
    if (getKey() != null) {
      final String value = serialize(model);
      return SharedPreferences.getInstance()
          .then((prefs) => prefs.setString(_serializationKey, value));
    }
    return Future.value(true);
  }

  Future<bool> clearValue() {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.remove(_serializationKey));
  }

  void dispose() {
    _subject.close();
  }

  /// Perform action at the bloc initialization
  void init() {}

  /// Get the name used for serialization, return null to disable serialization
  String? getKey() => null;

  String get _serializationKey => 'BLoC@${getKey() ?? ''}';

  String serialize(T model) => jsonEncode(toJson(model));

  T deserialize(String jsonStr) => fromJson(jsonDecode(jsonStr));

  dynamic toJson(T model) =>
      (model is List) ? model : model as Map<String, dynamic>;

  T fromJson(Map<String, dynamic> map) => map as T;
}
