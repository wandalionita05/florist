import 'package:get/get.dart';

class DeliveryPreferencesController extends GetxController {
  var deliveryTime = 'Morning'.obs;
  var contactlessDelivery = false.obs;
  var notes = ''.obs;

  void updateDeliveryTime(String value) {
    deliveryTime.value = value;
  }

  void toggleContactless(bool value) {
    contactlessDelivery.value = value;
  }

  void updateNotes(String value) {
    notes.value = value;
  }
}
