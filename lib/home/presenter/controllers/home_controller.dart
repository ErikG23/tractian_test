import 'package:tractian_test/home/domain/entities/item_entity.dart';
import 'package:tractian_test/home/domain/entities/company_entity.dart';
import 'package:tractian_test/home/domain/entities/location_entity.dart';
import 'package:tractian_test/home/domain/entities/tree_entity.dart';
import 'package:tractian_test/home/domain/helpers/enums/type_state_enum.dart';
import 'package:tractian_test/home/presenter/stores/home_state.dart';
import '../stores/home_store.dart';

class HomeController {
  final HomeStore _homeStore;

  HomeController({
    required HomeStore homeStore,
  }) : _homeStore = homeStore;

  // Access to the HomeStore instance
  HomeStore get store => _homeStore;

  // Access to the HomeState
  HomeState get state => store.state;

  // Accessors for store variables
  List<CompanyEntity> get companies => state.listCompanies;
  bool get isSensorSelected => state.typeSensorSelected;
  bool get isAlertSelected => state.typeAlertSelected;
  List<TreeEntity> get treeNodes => state.listTreeNode;
  List<TreeEntity> get searchedTreeNodes => state.listTreeNodeSearched;

  // Fetches the list of companies
  Future<void> fetchCompanies() async {
    await _homeStore.fetchCompanies();
  }

  // Clears the stored data
  void clearData() {
    _homeStore.resetData();
  }

  // Updates the search query and filters the tree
  void updateSearchQuery(String query) {
    _homeStore.setSearchTerm(query);
    filterTree();
  }

  // Toggles sensor selection and filters the tree
  void toggleSensorSelection() {
    _homeStore.toggleSensorSelection();
    filterTree();
  }

  // Toggles alert selection and filters the tree
  void toggleAlertSelection() {
    _homeStore.toggleAlertSelection();
    filterTree();
  }

  // Filters the tree based on search query and type selection
  void filterTree() {
    final filtered = _filterTreeEntities(
      searchedTreeNodes,
      state.searchQuery,
    );
    _homeStore.updateTreeNodes(filtered);
  }

  // Recursively filters tree entities based on the search query
  List<TreeEntity> _filterTreeEntities(List<TreeEntity> nodes, String query) {
    return nodes
        .map((node) => _filterTreeNode(node, query))
        .where((node) => node != null)
        .cast<TreeEntity>()
        .toList();
  }

  // Filters a single tree node and its children
  TreeEntity? _filterTreeNode(TreeEntity node, String query) {
    final matchesQuery = node.item.name.toLowerCase().contains(
          query.toLowerCase(),
        );
    final typeState = _determineTypeState();

    final matchesTypeState = typeState == null || node.item.status == typeState;
    final filteredChildren = _filterChildren(node.children, query, typeState);

    if ((matchesQuery && matchesTypeState) || filteredChildren.isNotEmpty) {
      return node.copyWith(children: filteredChildren);
    } else {
      return null;
    }
  }

  // Filters the children of a node
  List<dynamic> _filterChildren(
      List<dynamic> children, String query, TypeSensorEnum? typeState) {
    final filtered = <dynamic>[];

    for (var child in children) {
      if (child is TreeEntity) {
        final filteredChild = _filterTreeNode(child, query);
        if (filteredChild != null) {
          filtered.add(filteredChild);
        }
      } else if (child is ItemEntity || child is LocationEntity) {
        final matchesQuery =
            child.name.toLowerCase().contains(query.toLowerCase());
        final matchesType = typeState == null || child.status == typeState;
        if (matchesQuery && matchesType) {
          filtered.add(child);
        }
      }
    }

    return filtered;
  }

  // Determines the type state based on current selection
  TypeSensorEnum? _determineTypeState() {
    if (isAlertSelected) {
      return TypeSensorEnum.critical;
    } else if (isSensorSelected) {
      return TypeSensorEnum.sensor;
    }
    return null;
  }
}
