import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_test/core/failures/app_failure/i_app_failure.dart';
import 'package:tractian_test/home/domain/entities/company_entity.dart';
import 'package:tractian_test/home/infra/datasources/i_fetch_companies_datasource.dart';
import 'package:tractian_test/home/infra/repositories/fetch_companies_repository.dart';

import '../../mock/clean_dart_mock.dart';

class _DatasourceMock extends Mock implements IFetchCompaniesDatasource {}

void main() {
  final datasource = _DatasourceMock();
  final repository = FetchCompaniesRepository(datasource);
  test('Fetch companies repository', () async {
    when(() => datasource.execute()).thenAnswer((_) async => []);
    final result = await repository.fetch();
    expect(result.fold((l) => l, (r) => r), isA<List<CompanyEntity>>());
  });

  test('Fetch companies repository failure', () async {
    when(() => datasource.execute()).thenThrow(appExceptionMock);
    final result = await repository.fetch();
    expect(result.fold((l) => l, (r) => r), isA<IAppException>());
  });
}
