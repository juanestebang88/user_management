import 'package:hive/hive.dart';

import '../models/user_model.dart';
import '../../domain/entities/user.dart';

class HiveUserDataSource {
  final Box<UserModel> hiveBox;

  HiveUserDataSource(this.hiveBox);

  Future<List<User>> fetchUsers() async {
    try {
      return hiveBox.values.map((userModel) => userModel.toEntity()).toList();
    } catch (e) {
      throw Exception('Error al obtener usuarios: $e');
    }
  }

  Future<void> saveUser(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      await hiveBox.put(user.id, userModel);
    } catch (e) {
      throw Exception('Error al guardar el usuario: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await hiveBox.delete(userId);
    } catch (e) {
      throw Exception('Error al eliminar el usuario: $e');
    }
  }
}
