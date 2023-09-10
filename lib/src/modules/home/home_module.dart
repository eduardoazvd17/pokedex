import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/modules/home/presentation/pages/details_page.dart';
import 'package:pokedex/src/modules/home/data/bindings/home_binding.dart';
import 'package:pokedex/src/modules/home/presentation/controllers/home_controller.dart';
import 'package:pokedex/src/modules/home/presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) => HomeBinding().dependencies();

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => HomePage(controller: Get.find<HomeController>()),
      children: [
        ChildRoute('/details', child: (_) => const DetailsPage()),
      ],
    );
  }
}
