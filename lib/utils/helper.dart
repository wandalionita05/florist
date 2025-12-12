import 'package:get/get.dart';
import 'package:florist/domain/cartViewModel.dart';
import 'package:florist/domain/categorieViewModel.dart';
import 'package:florist/domain/productViewModel.dart';
import 'package:florist/domain/user_controller.dart';
import 'package:florist/domain/delivery_preferences_controller.dart';
import 'package:florist/domain/location_controller.dart';
import 'package:florist/models/product_repo_Impl.dart';
import 'package:florist/models/shopingCart_repo_impl.dart';
import 'package:florist/models/source/local/cart_local_storage.dart';
import 'package:florist/models/source/local/product_local_storage.dart';
import 'package:florist/models/source/remote/api.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:florist/constants/appConstants.dart';

Future initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(DeliveryPreferencesController(), permanent: true);

  /// LOCAL STORAGE
  Get.lazyPut(() => LocalStorageImpl(sharedPreferences: sharedPreferences));
  Get.lazyPut(() => CartLocalStorageImpl(sharedPreferences: sharedPreferences));
  Get.put(LocationController(), permanent: true);

  /// API
  Get.lazyPut(() => ApiImpl(AppConstants.BASE_URL));

  /// REPOSITORY
  Get.lazyPut(() => ProductRepositoryImpl(
        api: Get.find<ApiImpl>(),
        localStorage: Get.find<LocalStorageImpl>(),
      ));

  Get.lazyPut(() => CartRepositoryImpl(
        cartLocalStorage: Get.find<CartLocalStorageImpl>(),
      ));

  /// VIEWMODEL
  Get.lazyPut(() => ProductViewModel(
        productRepositoryImpl: Get.find<ProductRepositoryImpl>(),
      ));

  Get.lazyPut(() => ShoppingCartViewModel(
        cartRepositoryImpl: Get.find<CartRepositoryImpl>(),
      ));

  Get.put(CategorieViewModel());

  /// ✅ USER / PROFILE CONTROLLER (INI YANG KITA BUTUH)
  Get.put(UserController(), permanent: true);
}

Future<LottieComposition?> customDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(bytes, filePicker: (files) {
    return files.firstWhereOrNull(
      (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'),
    );
  });
}
