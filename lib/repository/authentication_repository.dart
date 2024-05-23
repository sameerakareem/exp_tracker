import 'dart:async';
import 'package:expence_tracker/repository/preference_repository.dart';
import 'package:flutter/foundation.dart';

import '../models/profile_model.dart';

enum AuthenticationStatus { unknown, expired, authenticated, unauthenticated }

class AuthenticationRepository {
 // Authentication? authentication;
  ProfileModel? selectedProfile;
  final PreferencesRepository _preferencesRepository;
  bool _isAuthenticated;

  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository(
      {required PreferencesRepository preferencesRepository})
      : _preferencesRepository = preferencesRepository,
        _isAuthenticated = preferencesRepository.getBool('isAuthenticated') {
  //  init();
  }

  // void init() async {
  //   ProfileModel? profileModel =
  //       await _preferencesRepository.getSelectedProfile();
  //   if (profileModel != null) {
  //     LoginManager loginManager = LoginManager(
  //         profileModel: profileModel,
  //         preferenceRepository: preferencesRepository);
  //     if (kDebugMode) {
  //       print(profileModel.toJson());
  //     }
  //     checkSessionExpiry(loginManager);
  //   }
  // }

  bool get isAuthenticated => _isAuthenticated;

  set setAuthenticated(bool value) {
    _isAuthenticated = value;
  }

  PreferencesRepository get preferencesRepository => _preferencesRepository;


  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required ProfileModel profileModel,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
