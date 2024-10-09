import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_test/core/failures/app_failure/i_app_failure.dart';
import 'package:tractian_test/home/domain/entities/location_entity.dart';
import 'package:tractian_test/home/infra/datasources/i_fetch_location_datasource.dart';
import 'package:tractian_test/home/infra/repositories/fetch_location_repository.dart';

import '../../mock/clean_dart_mock.dart';

class _DatasourceMock extends Mock implements IFetchLocationDatasource {}

void main() {
  final datasource = _DatasourceMock();
  final repository = FetchLocationRepository(datasource);
  test('Fetch location repository', () async {
    when(() => datasource.call(fetchLocationParamMock))
        .thenAnswer((_) async => []);
    final result = await repository.fetch(fetchLocationParamMock);
    expect(result.fold((l) => l, (r) => r), isA<List<LocationEntity>>());
  });

  test('Fetch location repository failure', () async {
    when(() => datasource.call(fetchLocationParamMock))
        .thenThrow(appExceptionMock);
    final result = await repository.fetch(fetchLocationParamMock);
    expect(result.fold((l) => l, (r) => r), isA<IAppException>());
  });
}
