import 'package:fpdart/fpdart.dart';
import '../../../../../core/failures/app_failure/i_app_failure.dart';
import '../../entities/location_entity.dart';
import '../../helpers/params/fetch_location_params.dart';

abstract class IFetchLocationUsecase {
  Future<Either<IAppException, List<LocationEntity>>> execute(
      FetchLocationParams params);
}
