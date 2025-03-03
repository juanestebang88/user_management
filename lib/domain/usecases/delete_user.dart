import '../repositories/user_repository.dart';

class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<void> call(String userId) async {
    await repository.deleteUser(userId);
  }
}
