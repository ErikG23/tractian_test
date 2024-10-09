import 'package:tractian_test/home/domain/entities/tree_entity.dart';
import 'package:tractian_test/home/external/mappers/item_converter.dart';

class TreeMapper {
  static TreeEntity fromMap(Map<String, dynamic> map) {
    return TreeEntity(
      item: ItemConverter.fromJson(map),
      children: [],
    );
  }
}
