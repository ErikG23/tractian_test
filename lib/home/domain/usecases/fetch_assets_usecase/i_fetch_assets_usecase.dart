import 'package:fpdart/fpdart.dart';
import '../../../../../core/failures/app_failure/i_app_failure.dart';
import '../../entities/tree_entity.dart';
import '../../helpers/params/fetch_assets_params.dart';

abstract class IFetchAssetsUsecase {
  Future<Either<IAppException, List<TreeEntity>>> execute(
      FetchAssetsParams params);
}
