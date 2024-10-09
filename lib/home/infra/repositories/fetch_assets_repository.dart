import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tractian_test/core/failures/app_failure/i_app_failure.dart';
import 'package:tractian_test/home/domain/entities/tree_entity.dart';
import 'package:tractian_test/home/domain/helpers/params/fetch_assets_params.dart';
import 'package:tractian_test/home/domain/repositories/i_fetch_assets_repository.dart';
import 'package:tractian_test/home/external/mappers/tree_mapper.dart';
import 'package:tractian_test/home/infra/datasources/i_fetch_assets_datasource.dart';

class FetchAssetsRepository implements IFetchAssetsRepository {
  final IFetchAssetsDatasource _assetsDatasource;

  const FetchAssetsRepository(this._assetsDatasource);

  @override
  Future<Either<IAppException, List<TreeEntity>>> fetch(
      FetchAssetsParams parameters) async {
    try {
      final response = await _assetsDatasource(parameters);
      final assetsList = await compute(_processAssetsData, response);

      return Right(assetsList);
    } on IAppException catch (e) {
      return Left(e);
    }
  }
}

/// Processes raw asset data into a list of [TreeEntity].
List<TreeEntity> _processAssetsData(List<Map<String, dynamic>> rawData) {
  return rawData.map((data) => TreeMapper.fromMap(data)).toList();
}
