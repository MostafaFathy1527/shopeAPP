
import 'package:get/get.dart';
import '../core/view_model/auth_view_model.dart';
import 'package:shope/core/view_model/cart_viewmodel.dart';
import '../core/view_model/control_view_model.dart';
import '../core/view_model/home_view_model.dart';


class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CartViewModel());

  }
}