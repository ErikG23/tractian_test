import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_test/core/failures/app_failure/i_app_failure.dart';
import 'package:tractian_test/home/domain/entities/tree_entity.dart';
import 'package:tractian_test/home/infra/datasources/i_fetch_assets_datasource.dart';
import 'package:tractian_test/home/infra/repositories/fetch_assets_repository.dart';

import '../../mock/clean_dart_mock.dart';

class _DatasourceMock extends Mock implements IFetchAssetsDatasource {}

void main() {
  final datasource = _DatasourceMock();
  final repository = FetchAssetsRepository(datasource);
  test('Fetch assets repository', () async {
    when(() => datasource.call(fetchAssetsParam)).thenAnswer((_) async => []);
    final result = await repository.fetch(fetchAssetsParam);
    expect(result.fold((l) => l, (r) => r), isA<List<TreeEntity>>());
  });

  test('Fetch assets repository failure', () async {
    when(() => datasource.call(fetchAssetsParam)).thenThrow(appExceptionMock);
    final result = await repository.fetch(fetchAssetsParam);
    expect(result.fold((l) => l, (r) => r), isA<IAppException>());
  });
}
