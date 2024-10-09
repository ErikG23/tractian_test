import 'package:tractian_test/core/failures/app_failure/app_failure.dart';
import 'package:tractian_test/core/shared/services/dio_service/helpers/params/http_param.dart';
import 'package:tractian_test/core/shared/services/dio_service/helpers/responses/http_response.dart';
import 'package:tractian_test/home/domain/entities/item_entity.dart';
import 'package:tractian_test/home/domain/entities/location_entity.dart';
import 'package:tractian_test/home/domain/entities/tree_entity.dart';
import 'package:tractian_test/home/domain/helpers/enums/type_item_enum.dart';
import 'package:tractian_test/home/domain/helpers/params/fetch_assets_params.dart';
import 'package:tractian_test/home/domain/helpers/params/fetch_location_params.dart';

final fetchLocationParamMock = FetchLocationParams(companyId: '');
const fetchAssetsParam = FetchAssetsParams(companyId: '');
final appExceptionMock = AppException(message: 'message');
final httpParamMock = HttpParam(url: '');

final httpResponse = HttpResponse(response: [
  {
    "id": "656a07bbf2d4a1001e2144c2",
    "name": "CONVEYOR BELT ASSEMBLY",
    "locationId": "656a07b3f2d4a1001e2144bf"
  }
]);

const assetEntityMock = ItemEntity(
  id: '3',
  name: 'name',
  gatewayId: 'gatewayId',
  typeItem: TypeItemEnum.asset,
  parentId: '0',
);

const treeEntityMock = TreeEntity(
  item: ItemEntity(
    id: '0',
    name: 'name',
    typeItem: TypeItemEnum.location,
  ),
  children: [assetEntityMock],
);

final List<TreeEntity> listTreeMock = [
  treeEntityMock,
  const TreeEntity(
    item: ItemEntity(
      id: '1',
      name: 'name',
      typeItem: TypeItemEnum.asset,
      parentId: '0',
    ),
    children: [
      ItemEntity(
        id: 'id',
        name: 'name',
        gatewayId: 'gatewayId',
        typeItem: TypeItemEnum.asset,
        parentId: '1',
      )
    ],
  ),
  const TreeEntity(
    item: ItemEntity(
      id: '123',
      name: 'name',
      typeItem: TypeItemEnum.component,
      sensorType: 'sensorType',
    ),
    children: [],
  ),
];

final List<LocationEntity> listLocation = [
  const LocationEntity(
    id: '1',
    name: 'name',
    locationChildren: [],
    typeItem: TypeItemEnum.location,
  ),
  const LocationEntity(
    id: '2',
    name: 'name',
    locationChildren: [],
    typeItem: TypeItemEnum.location,
    parentId: '1',
  ),
];
