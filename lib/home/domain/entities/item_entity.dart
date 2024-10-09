import 'package:tractian_test/home/domain/helpers/enums/type_item_enum.dart';
import 'package:tractian_test/home/domain/helpers/enums/type_state_enum.dart';

class ItemEntity {
  final String id;
  final String name;
  final String? sensorId;
  final String? parentId;
  final String? gatewayId;
  final String? sensorType;
  final String? locationId;
  final TypeItemEnum typeItem;
  final TypeSensorEnum? status;

  const ItemEntity({
    required this.id,
    required this.name,
    required this.typeItem,
    this.status,
    this.parentId,
    this.sensorId,
    this.gatewayId,
    this.locationId,
    this.sensorType,
  });
}
