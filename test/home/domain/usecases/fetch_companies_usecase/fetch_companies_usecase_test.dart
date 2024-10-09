import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_test/core/failures/app_failure/i_app_failure.dart';
import 'package:tractian_test/home/domain/entities/company_entity.dart';
import 'package:tractian_test/home/domain/repositories/i_fetch_companies_repository.dart';
import 'package:tractian_test/home/domain/usecases/fetch_companies_usecase/fetch_companies_usecase.dart';

import '../../../mock/clean_dart_mock.dart';

class Repository extends Mock implements IFetchCompaniesRepository {}

void main() {
  final repository = Repository();
  final usecase = FetchCompaniesUsecase(repository);
  test('Fetch companies usecase', () async {
    when(() => repository.fetch())
        .thenAnswer((invocation) async => const Right([]));
    final result = await usecase.call();
    expect(result.fold((l) => l, (r) => r), isA<List<CompanyEntity>>());
  });

  test('Fetch companies failure', () async {
    when(() => repository.fetch())
        .thenAnswer((invocation) async => Left(appExceptionMock));
    final result = await usecase.call();
    expect(result.fold((l) => l, (r) => r), isA<IAppException>());
  });
}
