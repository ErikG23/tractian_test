import '../../domain/helpers/params/fetch_assets_params.dart';

abstract class IFetchAssetsDatasource {
  Future<List<Map<String, dynamic>>> call(FetchAssetsParams params);
}
