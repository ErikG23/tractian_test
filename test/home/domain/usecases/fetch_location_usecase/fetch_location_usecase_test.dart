import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_test/core/failures/app_failure/i_app_failure.dart';
import 'package:tractian_test/home/domain/entities/location_entity.dart';
import 'package:tractian_test/home/domain/repositories/i_fetch_location_repository.dart';
import 'package:tractian_test/home/domain/usecases/fetch_location_usecase/fetch_location_usecase.dart';

import '../../../mock/clean_dart_mock.dart';

class Repository extends Mock implements IFetchLocationRepository {}

void main() {
  final repository = Repository();
  final usecase = FetchLocationUsecase(repository);
  test('Fetch location usecase', () async {
    when(() => repository.fetch(fetchLocationParamMock))
        .thenAnswer((invocation) async => Right(listLocation));
    final result = await usecase.execute(fetchLocationParamMock);
    expect(result.fold((l) => l, (r) => r), isA<List<LocationEntity>>());
  });

  test('Fetch location failure', () async {
    when(() => repository.fetch(fetchLocationParamMock))
        .thenAnswer((invocation) async => Left(appExceptionMock));
    final result = await usecase.execute(fetchLocationParamMock);
    expect(result.fold((l) => l, (r) => r), isA<IAppException>());
  });
}
