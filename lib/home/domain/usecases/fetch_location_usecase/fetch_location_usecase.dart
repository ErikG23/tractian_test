import 'package:fpdart/fpdart.dart';
import 'package:tractian_test/home/domain/entities/location_entity.dart';
import 'package:tractian_test/home/domain/helpers/params/fetch_location_params.dart';
import 'package:tractian_test/home/domain/repositories/i_fetch_location_repository.dart';
import 'package:tractian_test/home/domain/usecases/fetch_location_usecase/i_retrieve_location_usecase.dart';

import '../../../../../core/failures/app_failure/i_app_failure.dart';

class FetchLocationUsecase implements IFetchLocationUsecase {
  final IFetchLocationRepository _locationRepository;

  const FetchLocationUsecase(this._locationRepository);

  @override
  Future<Either<IAppException, List<LocationEntity>>> execute(
      FetchLocationParams parameters) async {
    final repositoryResponse = await _locationRepository.fetch(parameters);

    final processedResult = repositoryResponse.fold(
      (failure) => failure,
      (locations) => locations,
    );

    if (processedResult is IAppException) {
      return Left(processedResult);
    }

    final locationsList = processedResult as List<LocationEntity>;

    // Identify parent locations (no parentId)
    final parentLocations =
        locationsList.where((loc) => loc.parentId == null).toList();

    // Identify child locations (have parentId)
    final childLocations =
        locationsList.where((loc) => loc.parentId != null).toList();

    // Associate child locations with their respective child locations
    for (var i = 0; i < childLocations.length; i++) {
      final children = childLocations
          .where((child) => child.parentId == childLocations[i].id)
          .toList();
      childLocations[i] = childLocations[i].copyWith(
        locationChildren: children,
      );
    }

    // Associate child locations with their respective parent locations
    for (var i = 0; i < parentLocations.length; i++) {
      final children = childLocations
          .where((child) => child.parentId == parentLocations[i].id)
          .toList();
      parentLocations[i] = parentLocations[i].copyWith(
        locationChildren: children,
      );
    }

    return Right(parentLocations);
  }
}
