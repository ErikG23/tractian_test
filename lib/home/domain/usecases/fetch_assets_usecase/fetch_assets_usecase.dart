import 'package:fpdart/fpdart.dart';
import 'package:tractian_test/home/domain/entities/tree_entity.dart';
import 'package:tractian_test/home/domain/repositories/i_fetch_assets_repository.dart';
import '../../../../../core/failures/app_failure/i_app_failure.dart';
import '../../helpers/params/fetch_assets_params.dart';
import 'i_fetch_assets_usecase.dart';

class FetchAssetsUsecase implements IFetchAssetsUsecase {
  final IFetchAssetsRepository _assetsRepository;

  const FetchAssetsUsecase(this._assetsRepository);

  @override
  Future<Either<IAppException, List<TreeEntity>>> execute(
      FetchAssetsParams parameters) async {
    final repositoryResponse = await _assetsRepository.fetch(parameters);

    final processedResult = repositoryResponse.fold(
      (failure) => failure,
      (assets) => assets,
    );

    if (processedResult is IAppException) {
      return Left(processedResult);
    }

    final assetsList = processedResult as List<TreeEntity>;

    // Assets containing sensor types
    final sensorAssets =
        assetsList.where((asset) => asset.item.sensorType != null).toList();

    // Assets that have a location as their parent
    final parentAssets =
        assetsList.where((asset) => asset.item.locationId != null).toList();

    // Assets that are children of other assets
    final childAssets =
        assetsList.where((asset) => asset.item.parentId != null).toList();

    // Associate children with their respective parent assets
    for (var i = 0; i < childAssets.length; i++) {
      final children = childAssets
          .where((child) => child.item.parentId == childAssets[i].item.id)
          .toList();

      childAssets[i] = childAssets[i].copyWith(children: children);
    }

    // Attach children to their parent assets
    for (var i = 0; i < parentAssets.length; i++) {
      final children = childAssets
          .where((child) => child.item.parentId == parentAssets[i].item.id)
          .toList();

      parentAssets[i] = parentAssets[i].copyWith(children: children);
    }

    // Include sensor components that are not linked to any parent or location
    for (var component in sensorAssets) {
      if (component.item.parentId == null &&
          component.item.locationId == null) {
        parentAssets.add(component);
      }
    }

    return Right(parentAssets);
  }
}
