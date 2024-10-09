import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_test/core/core_module.dart';
import 'package:tractian_test/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.module(
      Modular.initialRoute,
      module: HomeModule(),
    );
  }
}
