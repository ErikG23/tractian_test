import 'package:flutter_triple/flutter_triple.dart';
import 'package:tractian_test/home/domain/entities/tree_entity.dart';
import 'package:tractian_test/home/domain/usecases/fetch_companies_usecase/i_fetch_companies_usecase.dart';
import 'package:tractian_test/home/domain/usecases/build_tree_structure_usecase/i_build_tree_structure_usecase.dart';
import 'home_state.dart';

class HomeStore extends Store<HomeState> {
  final IFetchCompaniesUsecase _companiesUsecase;
  final IBuildTreeStructureUsecase _treeNodeUsecase;

  HomeStore({
    required IFetchCompaniesUsecase fetchCompaniesUsecase,
    required IBuildTreeStructureUsecase generateTreeNodeUsecase,
  })  : _companiesUsecase = fetchCompaniesUsecase,
        _treeNodeUsecase = generateTreeNodeUsecase,
        super(HomeState.init());

  // Fetches the list of companies and updates the state
  Future<void> fetchCompanies() async {
    final result = await _companiesUsecase.call();
    result.fold(
      (failure) => setError(failure),
      (companies) => update(state.copyWith(listCompanies: companies)),
    );
  }

  // Toggles the sensor selection state
  void toggleSensorSelection() {
    update(
      state.copyWith(
        typeSensorSelected: !state.typeSensorSelected,
        typeAlertSelected: false,
      ),
    );
  }

  // Toggles the alert selection state
  void toggleAlertSelection() {
    update(
      state.copyWith(
        typeSensorSelected: false,
        typeAlertSelected: !state.typeAlertSelected,
      ),
    );
  }

  // Generates tree nodes for a given company
  Future<void> loadTreeNodes(String companyId) async {
    setLoading(true);
    try {
      final nodes = await _treeNodeUsecase.constructTree(companyId: companyId);
      update(state.copyWith(
        listTreeNode: nodes,
        listTreeNodeSearched: nodes,
      ));
    } catch (error) {
      setError(error);
    }
    setLoading(false);
  }

  // Updates the list of tree nodes
  void updateTreeNodes(List<TreeEntity> treeNodes) {
    update(state.copyWith(listTreeNode: treeNodes));
  }

  // Sets the search query and updates the state
  void setSearchTerm(String searchTerm) {
    update(state.copyWith(searchQuery: searchTerm));
  }

  // Resets the data that is not needed on the home header page
  void resetData() {
    update(state.clearData());
  }
}
