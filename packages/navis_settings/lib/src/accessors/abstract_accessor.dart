import 'package:drift/drift.dart';

abstract class FilterAccessor<T extends DataClass> {
  Future<int> addFilter(covariant T filter);
  Future<void> removeFilter(int id);
  Future<List<T>> getAll();
  Future<int?> doesExist(covariant T filter);
  Future<T?> getFilter(int id);
}
