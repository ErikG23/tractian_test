import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_test/core/failures/app_failure/i_app_failure.dart';
import 'package:tractian_test/home/domain/entities/tree_entity.dart';
import 'package:tractian_test/home/domain/repositories/i_fetch_assets_repository.dart';
import 'package:tractian_test/home/domain/usecases/fetch_assets_usecase/fetch_assets_usecase.dart';

import '../../../mock/clean_dart_mock.dart';

class Repository extends Mock implements IFetchAssetsRepository {}

void main() {
  final repository = Repository();
  final usecase = FetchAssetsUsecase(repository);
  test('Fetch assets usecase', () async {
    when(() => repository.fetch(fetchAssetsParam))
        .thenAnswer((invocation) async => Right(listTreeMock));
    final result = await usecase.execute(fetchAssetsParam);
    expect(result.fold((l) => l, (r) => r), isA<List<TreeEntity>>());
  });

  test('Get assets failure', () async {
    when(() => repository.fetch(fetchAssetsParam))
        .thenAnswer((invocation) async => Left(appExceptionMock));
    final result = await usecase.execute(fetchAssetsParam);
    expect(result.fold((l) => l, (r) => r), isA<IAppException>());
  });
}
