import 'package:tractian_test/home/domain/entities/item_entity.dart';
import 'package:tractian_test/home/domain/helpers/enums/type_item_enum.dart';
import 'package:tractian_test/home/domain/helpers/enums/type_state_enum.dart';

class ItemConverter {
  /// Transforms a Map into an [ItemEntity] instance.
  static ItemEntity fromJson(Map<String, dynamic> json) {
    return ItemEntity(
      id: json['id'],
      name: json['name'],
      status: _determineItemStatus(json),
      gatewayId: json['gatewayId'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
      locationId: json['locationId'],
      typeItem: _determineItemType(json),
    );
  }

  /// Determines the [TypeItemEnum] based on the presence of 'sensorType'.
  static TypeItemEnum _determineItemType(Map<String, dynamic> json) {
    return json.containsKey('sensorType') && json['sensorType'] != null
        ? TypeItemEnum.component
        : TypeItemEnum.asset;
  }

  /// Maps the 'status' field to the corresponding [TypeSensorEnum].
  static TypeSensorEnum? _determineItemStatus(Map<String, dynamic> json) {
    switch (json['status']) {
      case 'operating':
        return TypeSensorEnum.sensor;
      case 'alert':
        return TypeSensorEnum.critical;
      default:
        return null;
    }
  }
}
