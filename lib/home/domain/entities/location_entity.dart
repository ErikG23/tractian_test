import 'package:tractian_test/home/domain/helpers/enums/type_item_enum.dart';

class LocationEntity {
  final String id;
  final String name;
  final String? parentId;
  final TypeItemEnum typeItem;
  final List<dynamic> locationChildren;

  const LocationEntity({
    this.parentId,
    required this.id,
    required this.name,
    required this.typeItem,
    required this.locationChildren,
  });

  LocationEntity copyWith({
    String? id,
    String? name,
    String? parentId,
    TypeItemEnum? typeItem,
    List<dynamic>? locationChildren,
  }) {
    return LocationEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      typeItem: typeItem ?? this.typeItem,
      locationChildren: locationChildren ?? this.locationChildren,
    );
  }
}
