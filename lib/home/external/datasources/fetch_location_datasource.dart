import '../../../core/shared/services/dio_service/helpers/params/http_param.dart';
import '../../../core/shared/services/dio_service/i_http_service.dart';
import '../../domain/helpers/params/fetch_location_params.dart';
import '../../infra/datasources/i_fetch_location_datasource.dart';

class FetchLocationDatasource implements IFetchLocationDatasource {
  final IDioService _dioService;

  FetchLocationDatasource({
    required IDioService dioService,
  }) : _dioService = dioService;

  @override
  Future<List<Map<String, dynamic>>> call(FetchLocationParams params) async {
    final requestResponse = await _dioService.get(
      HttpParam(
        url:
            'https://fake-api.tractian.com/companies/${params.companyId}/locations',
      ),
    );
    final List<Map<String, dynamic>> typedListData = requestResponse.response
        .map((item) => item as Map<String, dynamic>)
        .toList();

    return typedListData;
  }
}
