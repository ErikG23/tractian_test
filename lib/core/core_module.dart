import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'shared/services/dio_service/http_service.dart';
import 'shared/services/dio_service/i_http_service.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);
    i.addLazySingleton((i) => Dio());
    i.add<IDioService>(DioService.new);
  }
}
