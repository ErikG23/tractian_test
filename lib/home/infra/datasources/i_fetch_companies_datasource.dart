import 'package:tractian_test/home/domain/entities/company_entity.dart';

abstract class IFetchCompaniesDatasource {
  Future<List<CompanyEntity>> execute();
}
