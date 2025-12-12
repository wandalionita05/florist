import 'package:flutter/material.dart';
import '../models/dto/user.dart';

class UserViewModel extends ChangeNotifier {
  User _user = User(
    id: '1',
    name: 'Guest',
    email: 'guest@mail.com',
    phone: '-',
    address: '-',
  );

  User get user => _user;

  /// READ
  void fetchUser() {
    notifyListeners();
  }

  /// UPDATE
  void updateUser({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) {
    _user = User(
      id: _user.id,
      name: name,
      email: email,
      phone: phone,
      address: address,
    );
    notifyListeners();
  }

  /// DELETE (contoh logout / reset)
  void clearUser() {
    _user = User(
      id: '',
      name: '',
      email: '',
      phone: '',
      address: '',
    );
    notifyListeners();
  }
}
