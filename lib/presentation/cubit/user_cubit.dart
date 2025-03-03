import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/usecases/add_user.dart';
import '../../domain/usecases/delete_user.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsers getUsers;
  final AddUser addUser;  
  final DeleteUser deleteUser;

  UserCubit({
    required this.getUsers,
    required this.addUser,
    required this.deleteUser,
  }) : super(UserInitial());

  Future<void> loadUsers() async {
    try {
      emit(UserLoading());
      final users = await getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Error al cargar usuarios: $e'));
    }
  }

  Future<void> createUser(User user) async {
    try {
      emit(UserLoading());
      await addUser(user);
      final users = await getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Error al agregar el usuario: $e'));
    }
  }

  Future<void> removeUser(String userId) async {
    try {
      emit(UserLoading());
      await deleteUser(userId);
      final users = await getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Error al eliminar el usuario: $e'));
    }
  }
}
