import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_test/core/shared/services/dio_service/helpers/params/http_param.dart';
import 'package:tractian_test/core/shared/services/dio_service/i_http_service.dart';
import 'package:tractian_test/home/domain/entities/company_entity.dart';
import 'package:tractian_test/home/external/datasources/fetch_companies_datasource.dart';

import '../../mock/clean_dart_mock.dart';

class IDioServiceMock extends Mock implements IDioService {}

class DioParamFake extends Fake implements HttpParam {}

void main() {
  final iDioService = IDioServiceMock();
  final datasource = FetchCompaniesDatasource(dioService: iDioService);

  setUpAll(() {
    registerFallbackValue(DioParamFake());
  });

  test('Fetch company datasource', () async {
    when(() => iDioService.get(any())).thenAnswer(
      (invocation) async => httpResponse,
    );
    final result = await datasource.execute();
    expect(result, isA<List<CompanyEntity>>());
  });
}
