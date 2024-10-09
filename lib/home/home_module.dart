import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_test/core/core_module.dart';
import 'package:tractian_test/home/domain/usecases/fetch_location_usecase/fetch_location_usecase.dart';
import 'package:tractian_test/home/domain/usecases/build_tree_structure_usecase/build_tree_structure_usecase.dart';
import 'package:tractian_test/home/domain/usecases/fetch_location_usecase/i_retrieve_location_usecase.dart';
import 'package:tractian_test/home/external/datasources/fetch_location_datasource.dart';
import 'package:tractian_test/home/infra/repositories/fetch_location_repository.dart';
import 'package:tractian_test/home/presenter/controllers/home_controller.dart';
import 'package:tractian_test/home/presenter/pages/home_header.dart';
import 'package:tractian_test/home/presenter/pages/home_page.dart';
import 'package:tractian_test/home/presenter/stores/home_store.dart';

import 'domain/repositories/i_fetch_assets_repository.dart';
import 'domain/repositories/i_fetch_companies_repository.dart';
import 'domain/repositories/i_fetch_location_repository.dart';
import 'domain/usecases/build_tree_structure_usecase/i_build_tree_structure_usecase.dart';
import 'domain/usecases/fetch_assets_usecase/fetch_assets_usecase.dart';
import 'domain/usecases/fetch_assets_usecase/i_fetch_assets_usecase.dart';
import 'domain/usecases/fetch_companies_usecase/fetch_companies_usecase.dart';
import 'domain/usecases/fetch_companies_usecase/i_fetch_companies_usecase.dart';
import 'external/datasources/fetch_assets_datasource.dart';
import 'external/datasources/fetch_companies_datasource.dart';
import 'infra/datasources/i_fetch_assets_datasource.dart';
import 'infra/datasources/i_fetch_companies_datasource.dart';
import 'infra/datasources/i_fetch_location_datasource.dart';
import 'infra/repositories/fetch_assets_repository.dart';
import 'infra/repositories/fetch_companies_repository.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    super.binds(i);

    // Controller
    i.addLazySingleton(HomeController.new);

    // Store
    i.addLazySingleton(HomeStore.new);

    // Location
    i.addLazySingleton<IFetchLocationUsecase>(FetchLocationUsecase.new);
    i.addLazySingleton<IFetchLocationRepository>(FetchLocationRepository.new);
    i.addLazySingleton<IFetchLocationDatasource>(FetchLocationDatasource.new);

    // Company
    i.addLazySingleton<IFetchCompaniesUsecase>(FetchCompaniesUsecase.new);
    i.addLazySingleton<IFetchCompaniesRepository>(FetchCompaniesRepository.new);
    i.addLazySingleton<IFetchCompaniesDatasource>(FetchCompaniesDatasource.new);

    // Assets
    i.addLazySingleton<IFetchAssetsUsecase>(FetchAssetsUsecase.new);
    i.addLazySingleton<IFetchAssetsRepository>(FetchAssetsRepository.new);
    i.addLazySingleton<IFetchAssetsDatasource>(FetchAssetsDatasource.new);

    // Build tree structure
    i.addLazySingleton<IBuildTreeStructureUsecase>(
        BuildTreeStructureUsecase.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(
      '/',
      child: (_) => HomeHeader(
        homeController: Modular.get<HomeController>(),
      ),
    );
    r.child(
      '/home',
      child: (_) => HomePage(
        homeController: Modular.get<HomeController>(),
        company: r.args.data['company'],
      ),
    );
  }
}
