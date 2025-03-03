import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/hive_user_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final HiveUserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<List<User>> getUsers() async {
    try {
      return await dataSource.fetchUsers();
    } catch (e) {
      throw Exception('Error al obtener usuarios: $e');
    }
  }

  @override
  Future<void> addUser(User user) async {
    try {
      await dataSource.saveUser(user);
    } catch (e) {
      throw Exception('Error al guardar usuario: $e');
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await dataSource.deleteUser(userId);
    } catch (e) {
      throw Exception('Error al eliminar usuario: $e');
    }
  }
}
