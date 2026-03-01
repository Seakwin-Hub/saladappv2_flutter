abstract class RepositoryInterface<T> {
  Future<dynamic> add(T value);

  Future<dynamic> getList({int? offSet});

  Future<dynamic> getData(String? id);
}
