import 'dart:convert';

import 'package:farmers_guide/models/user.dart';
import 'package:farmers_guide/networking/users_remote.dart';
import 'package:farmers_guide/services/abstract_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _UserMeState extends AbstractState<User> {
  final _userme = BehaviorSubject<User>();
  static const _serializationKey = 'state@user';

  _UserMeState();

  Future<void> initialise() async {
    final prefs = await SharedPreferences.getInstance();

    String? value = prefs.getString(_serializationKey);
    if (value == null) return;
    _userme.add(deserialize(value));
  }

  Future<User> fetch() async {
    final user = await UsersRemote.fetchUserMe();
    final _ = await setValue(user);
    return user;
  }

  @override
  Stream<User> get stream => _userme.stream;

  @override
  User? get value => _userme.valueOrNull;

  @override
  String? getKey() => _serializationKey;

  @override
  Future<bool> setValue(User model) {
    _userme.add(model);
    final String value = serialize(model);

    return SharedPreferences.getInstance()
        .then((prefs) => prefs.setString(_serializationKey, value));
  }

  @override
  User fromJson(Map<String, dynamic> map) => User.fromMap(map);

  @override
  Map<String, dynamic> toJson(User model) => model.toMap();

  @override
  String serialize(User model) => json.encode(model.toJson());

  @override
  User deserialize(String jsonStr) => User.fromJson(jsonDecode(jsonStr));
}

final userMeState = _UserMeState();
