import '../../domain/helpers/params/fetch_location_params.dart';

abstract class IFetchLocationDatasource {
  Future<List<Map<String, dynamic>>> call(FetchLocationParams params);
}
