import 'package:tractian_test/home/domain/entities/tree_entity.dart';

abstract class IBuildTreeStructureUsecase {
  Future<List<TreeEntity>> constructTree({
    required String companyId,
  });
}
