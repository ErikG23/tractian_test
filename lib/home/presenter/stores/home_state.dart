import 'package:tractian_test/home/domain/entities/company_entity.dart';
import 'package:tractian_test/home/domain/entities/tree_entity.dart';

class HomeState {
  final String searchQuery;
  final bool typeAlertSelected;
  final bool typeSensorSelected;
  final List<TreeEntity> listTreeNode;
  final List<CompanyEntity> listCompanies;
  final List<TreeEntity> listTreeNodeSearched;

  HomeState({
    required this.searchQuery,
    required this.listTreeNode,
    required this.listCompanies,
    required this.typeAlertSelected,
    required this.typeSensorSelected,
    required this.listTreeNodeSearched,
  });

  factory HomeState.init() => HomeState(
        searchQuery: '',
        listTreeNode: [],
        listCompanies: [],
        listTreeNodeSearched: [],
        typeAlertSelected: false,
        typeSensorSelected: false,
      );

  HomeState copyWith({
    String? searchQuery,
    bool? typeAlertSelected,
    bool? typeSensorSelected,
    List<TreeEntity>? listTreeNode,
    List<CompanyEntity>? listCompanies,
    List<TreeEntity>? listTreeNodeSearched,
  }) {
    return HomeState(
      searchQuery: searchQuery ?? this.searchQuery,
      listTreeNode: listTreeNode ?? this.listTreeNode,
      listCompanies: listCompanies ?? this.listCompanies,
      typeAlertSelected: typeAlertSelected ?? this.typeAlertSelected,
      typeSensorSelected: typeSensorSelected ?? this.typeSensorSelected,
      listTreeNodeSearched: listTreeNodeSearched ?? this.listTreeNodeSearched,
    );
  }

  HomeState clearData() {
    return copyWith(
      searchQuery: '',
      listCompanies: listCompanies,
      listTreeNode: [],
      listTreeNodeSearched: [],
      typeAlertSelected: false,
      typeSensorSelected: false,
    );
  }
}
