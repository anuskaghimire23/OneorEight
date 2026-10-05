
import 'package:football/controller/home_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {

  Get.put<HomeController>(HomeController(),permanent: true);

  }
}