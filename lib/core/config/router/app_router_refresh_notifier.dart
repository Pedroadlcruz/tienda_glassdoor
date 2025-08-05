import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/data/models/app_user.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../services/network/network_info.dart';

class AppRouterRefreshNotifier extends ChangeNotifier {
  final AuthRepository _authRepository;
  final NetworkInfo _networkInfo;

  StreamSubscription<AppUser>? _authStateSubscription;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  AppUser _currentUser = AppUser.empty;
  bool _isOnline = true;

  AppUser get currentUser => _currentUser;
  bool get isOnline => _isOnline;
  bool get isAuthenticated => _currentUser != AppUser.empty;

  AppRouterRefreshNotifier(this._authRepository, this._networkInfo) {
    _initializeListeners();
  }

  void _initializeListeners() {
    _authStateSubscription = _authRepository.authStateChanges.listen((user) {
      _currentUser = user;
      notifyListeners();
    });

    _connectivitySubscription = _networkInfo.onConnectivityChanged.listen((
      result,
    ) {
      _isOnline = _networkInfo.isOnline(result);
      notifyListeners();
    });

    _initializeConnectivityState();
  }

  Future<void> _initializeConnectivityState() async {
    try {
      final result = await _networkInfo.isConnected;
      _isOnline = result;
      notifyListeners();
    } catch (e) {
      _isOnline = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
