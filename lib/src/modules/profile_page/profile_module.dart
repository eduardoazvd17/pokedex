import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/profile_page.dart';

class ProfileModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/profile', child: (_) => const ProfilePage());
  }
}
