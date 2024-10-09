import 'package:tractian_test/home/domain/entities/item_entity.dart';
import 'package:tractian_test/home/domain/entities/location_entity.dart';
import 'package:tractian_test/home/domain/entities/tree_entity.dart';
import 'package:tractian_test/home/domain/helpers/enums/type_item_enum.dart';
import 'package:tractian_test/home/domain/helpers/params/fetch_assets_params.dart';
import 'package:tractian_test/home/domain/usecases/fetch_assets_usecase/i_fetch_assets_usecase.dart';
import 'package:tractian_test/home/domain/usecases/fetch_location_usecase/i_retrieve_location_usecase.dart';
import '../../helpers/params/fetch_location_params.dart';
import 'i_build_tree_structure_usecase.dart';

class BuildTreeStructureUsecase implements IBuildTreeStructureUsecase {
  final IFetchAssetsUsecase _assetsFetcher;
  final IFetchLocationUsecase _locationFetcher;

  const BuildTreeStructureUsecase(
    this._assetsFetcher,
    this._locationFetcher,
  );

  @override
  Future<List<TreeEntity>> constructTree({
    required String companyId,
  }) async {
    final locations = await _retrieveLocations(companyId);
    final assets = await _retrieveAssets(companyId);

    // Components without associated locations
    final orphanComponents =
        assets.where((asset) => asset.item.locationId == null).toList();

    final treeNodes = <TreeEntity>[];

    for (var location in locations) {
      final relatedAssets = assets
          .where((asset) => asset.item.locationId == location.id)
          .toList();

      if (relatedAssets.isNotEmpty) {
        final locationNode = location.copyWith(locationChildren: relatedAssets);
        treeNodes.add(
          TreeEntity(
            item: ItemEntity(
              id: location.id,
              name: location.name,
              typeItem: TypeItemEnum.location,
            ),
            children: locationNode.locationChildren,
          ),
        );
      } else if (location.locationChildren.isNotEmpty) {
        for (var childLocation in location.locationChildren) {
          final childAssets = assets
              .where((asset) => asset.item.locationId == childLocation.id)
              .toList();

          if (childAssets.isNotEmpty) {
            final childNode = location.copyWith(locationChildren: childAssets);
            treeNodes.add(
              TreeEntity(
                item: ItemEntity(
                  id: location.id,
                  name: location.name,
                  typeItem: TypeItemEnum.location,
                ),
                children: childNode.locationChildren,
              ),
            );
          }
        }
      } else {
        treeNodes.add(
          TreeEntity(
            item: ItemEntity(
              id: location.id,
              name: location.name,
              typeItem: TypeItemEnum.location,
            ),
            children: [],
          ),
        );
      }
    }

    // Incorporate orphan components into the tree
    for (var component in orphanComponents) {
      treeNodes.add(
        TreeEntity(
          item: ItemEntity(
            id: component.item.id,
            name: component.item.name,
            sensorType: component.item.sensorType,
            gatewayId: component.item.gatewayId,
            sensorId: component.item.sensorId,
            typeItem: TypeItemEnum.component,
            status: component.item.status,
          ),
          children: [],
        ),
      );
    }

    return treeNodes;
  }

  Future<List<TreeEntity>> _retrieveAssets(String companyId) async {
    final assetsResult = await _assetsFetcher.execute(
      FetchAssetsParams(companyId: companyId),
    );

    return assetsResult.fold(
      (failure) => throw failure,
      (assets) => assets,
    );
  }

  Future<List<LocationEntity>> _retrieveLocations(String companyId) async {
    final locationsResult = await _locationFetcher.execute(
      FetchLocationParams(companyId: companyId),
    );

    return locationsResult.fold(
      (failure) => throw failure,
      (locations) => locations,
    );
  }
}
