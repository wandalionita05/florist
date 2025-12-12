import 'package:get/get.dart';

class UserController extends GetxController {
  var name = 'Guest'.obs;
  var email = 'guest@mail.com'.obs;
  var phone = '-'.obs;
  var address = '-'.obs;

  /// UPDATE
  void updateUser({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) {
    this.name.value = name;
    this.email.value = email;
    this.phone.value = phone;
    this.address.value = address;
  }

  /// DELETE (logout)
  void clearUser() {
    name.value = '';
    email.value = '';
    phone.value = '';
    address.value = '';
  }
}
