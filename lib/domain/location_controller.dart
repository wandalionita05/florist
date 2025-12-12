import 'package:get/get.dart';

class LocationController extends GetxController {
  var addressLine = ''.obs;
  var city = ''.obs;
  var notes = ''.obs;

  void updateLocation({
    required String addressLine,
    required String city,
    required String notes,
  }) {
    this.addressLine.value = addressLine;
    this.city.value = city;
    this.notes.value = notes;
  }

  void clear() {
    addressLine.value = '';
    city.value = '';
    notes.value = '';
  }
}
