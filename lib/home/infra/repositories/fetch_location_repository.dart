import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/failures/app_failure/i_app_failure.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/helpers/params/fetch_location_params.dart';
import '../../domain/repositories/i_fetch_location_repository.dart';
import '../../external/mappers/location_mapper.dart';
import '../datasources/i_fetch_location_datasource.dart';

class FetchLocationRepository implements IFetchLocationRepository {
  final IFetchLocationDatasource _locationDatasource;

  const FetchLocationRepository(this._locationDatasource);

  @override
  Future<Either<IAppException, List<LocationEntity>>> fetch(
      FetchLocationParams params) async {
    try {
      final response = await _locationDatasource(params);
      final locationList = await compute(_processLocationData, response);
      return Right(locationList);
    } on IAppException catch (e) {
      return Left(e);
    }
  }
}

/// Processes the raw data into a list of [LocationEntity].
List<LocationEntity> _processLocationData(List<Map<String, dynamic>> data) {
  return data.map((map) => LocationMapper.fromMap(map)).toList();
}
