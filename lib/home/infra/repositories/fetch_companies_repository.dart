import 'package:fpdart/fpdart.dart';
import '../../../../core/failures/app_failure/i_app_failure.dart';
import '../../domain/entities/company_entity.dart';
import '../../domain/repositories/i_fetch_companies_repository.dart';
import '../datasources/i_fetch_companies_datasource.dart';

class FetchCompaniesRepository implements IFetchCompaniesRepository {
  final IFetchCompaniesDatasource _datasource;

  const FetchCompaniesRepository(this._datasource);

  @override
  Future<Either<IAppException, List<CompanyEntity>>> fetch() async {
    try {
      final fetchCompaniesDataResponse = await _datasource.execute();

      return Right(fetchCompaniesDataResponse);
    } on IAppException catch (e) {
      return Left(e);
    }
  }
}
