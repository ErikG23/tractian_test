import 'package:tractian_test/home/domain/helpers/enums/type_item_enum.dart';

import '../../domain/entities/location_entity.dart';

class LocationMapper {
  static LocationEntity fromMap(Map<String, dynamic> map) {
    return LocationEntity(
      id: map['id'],
      name: map['name'],
      parentId: map['parentId'],
      locationChildren: [],
      typeItem: TypeItemEnum.location,
    );
  }
}
