import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_test/core/shared/services/dio_service/helpers/params/http_param.dart';
import 'package:tractian_test/core/shared/services/dio_service/i_http_service.dart';
import 'package:tractian_test/home/external/datasources/fetch_assets_datasource.dart';

import '../../mock/clean_dart_mock.dart';

class IDioServiceMock extends Mock implements IDioService {}

class DioParamFake extends Fake implements HttpParam {}

void main() {
  final iDioService = IDioServiceMock();
  final datasource = FetchAssetsDatasource(dioService: iDioService);

  setUpAll(() {
    registerFallbackValue(DioParamFake());
  });

  test('Fetch assets datasource', () async {
    when(() => iDioService.get(any())).thenAnswer(
      (invocation) async => httpResponse,
    );
    final result = await datasource.call(fetchAssetsParam);
    expect(result, isA<List<Map<String, dynamic>>>());
  });
}
