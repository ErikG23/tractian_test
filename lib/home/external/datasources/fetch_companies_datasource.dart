import '../../../core/shared/services/dio_service/helpers/params/http_param.dart';
import '../../../core/shared/services/dio_service/i_http_service.dart';
import '../../domain/entities/company_entity.dart';
import '../../infra/datasources/i_fetch_companies_datasource.dart';
import '../mappers/company_mapper.dart';

class FetchCompaniesDatasource implements IFetchCompaniesDatasource {
  final IDioService _dioService;

  FetchCompaniesDatasource({
    required IDioService dioService,
  }) : _dioService = dioService;

  @override
  Future<List<CompanyEntity>> execute() async {
    final requestResponse = await _dioService.get(
      HttpParam(
        url: 'https://fake-api.tractian.com/companies',
      ),
    );

    final rawList = List<Map<String, dynamic>>.from(requestResponse.response);
    return rawList.map(CompanyMapper.fromMap).toList();
  }
}
