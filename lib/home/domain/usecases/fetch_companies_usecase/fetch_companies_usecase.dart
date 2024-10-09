import 'package:fpdart/fpdart.dart';
import '../../../../../core/failures/app_failure/i_app_failure.dart';
import '../../entities/company_entity.dart';
import '../../repositories/i_fetch_companies_repository.dart';
import 'i_fetch_companies_usecase.dart';

class FetchCompaniesUsecase implements IFetchCompaniesUsecase {
  final IFetchCompaniesRepository _repository;

  const FetchCompaniesUsecase(this._repository);

  @override
  Future<Either<IAppException, List<CompanyEntity>>> call() async {
    return await _repository.fetch();
  }
}
