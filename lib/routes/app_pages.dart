import 'package:football/routes/app_routes.dart';
import 'package:football/view/home_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [GetPage(name: AppRoutes.home, page: () => HomeView())];
}
