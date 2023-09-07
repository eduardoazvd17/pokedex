import 'package:get/get.dart';
import 'package:pokedex/features/home_page/presentation/controllers/home_page_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }
}
