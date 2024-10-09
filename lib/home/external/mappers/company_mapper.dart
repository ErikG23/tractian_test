import '../../domain/entities/company_entity.dart';

class CompanyMapper {
  static CompanyEntity fromMap(Map<String, dynamic> map) {
    return CompanyEntity(
      id: map['id'],
      companyName: map['name'],
    );
  }
}
