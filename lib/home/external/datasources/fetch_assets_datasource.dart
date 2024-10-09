import '../../../core/shared/services/dio_service/helpers/params/http_param.dart';
import '../../../core/shared/services/dio_service/i_http_service.dart';
import '../../domain/helpers/params/fetch_assets_params.dart';
import '../../infra/datasources/i_fetch_assets_datasource.dart';

class FetchAssetsDatasource implements IFetchAssetsDatasource {
  final IDioService _dioService;

  FetchAssetsDatasource({required IDioService dioService})
      : _dioService = dioService;

  @override
  Future<List<Map<String, dynamic>>> call(FetchAssetsParams params) async {
    final requestResponse = await _dioService.get(
      HttpParam(
        url:
            'https://fake-api.tractian.com/companies/${params.companyId}/assets',
      ),
    );

    final List<Map<String, dynamic>> assetsList = requestResponse.response
        .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
        .toList();

    return assetsList;
  }
}
