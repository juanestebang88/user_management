import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:user_management/domain/entities/user.dart';
import 'package:user_management/domain/usecases/add_user.dart';
import 'package:user_management/domain/usecases/delete_user.dart';
import 'package:user_management/domain/usecases/get_users.dart';
import 'package:user_management/presentation/cubit/user_cubit.dart';
import 'package:user_management/presentation/cubit/user_state.dart';

import 'user_cubit_test.mocks.dart';

@GenerateMocks([GetUsers, AddUser, DeleteUser])
void main() {
  // Declaramos las variables necesarias
  late MockGetUsers mockGetUsers;
  late MockAddUser mockAddUser;
  late MockDeleteUser mockDeleteUser;
  late UserCubit userCubit;

  // Datos de prueba
  final testUser = User(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    birthDate: DateTime(1990, 1, 1),
  );

  final testUserList = [
    User(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      birthDate: DateTime(1990, 1, 1),
    ),
  ];

  setUp(() {
    mockGetUsers = MockGetUsers();
    mockAddUser = MockAddUser();
    mockDeleteUser = MockDeleteUser();

    userCubit = UserCubit(
      getUsers: mockGetUsers,
      addUser: mockAddUser,
      deleteUser: mockDeleteUser,
    );
  });

  tearDown(() {
    userCubit.close();
  });

  group('loadUsers', () {
    blocTest<UserCubit, UserState>(
      'emite [UserLoading, UserLoaded] cuando getUsers tiene éxito',
      build: () {
        when(mockGetUsers()).thenAnswer((_) async => testUserList);
        return userCubit;
      },
      act: (cubit) => cubit.loadUsers(),
      expect: () => [UserLoading(), UserLoaded(testUserList)],
      verify: (_) {
        verify(mockGetUsers()).called(1);
      },
    );

    blocTest<UserCubit, UserState>(
      'emite [UserLoading, UserError] cuando getUsers lanza una excepción',
      build: () {
        when(mockGetUsers()).thenThrow(Exception('Error al cargar usuarios'));
        return userCubit;
      },
      act: (cubit) => cubit.loadUsers(),
      expect: () => [UserLoading(), UserError('Error al cargar usuarios: Exception: Error al cargar usuarios')],
      verify: (_) {
        verify(mockGetUsers()).called(1);
      },
    );
  });

  group('createUser', () {
    blocTest<UserCubit, UserState>(
      'emite [UserLoading, UserLoaded] cuando addUser tiene éxito',
      build: () {
        when(mockAddUser(testUser)).thenAnswer((_) async => {});
        when(mockGetUsers()).thenAnswer((_) async => testUserList);
        return userCubit;
      },
      act: (cubit) => cubit.createUser(testUser),
      expect: () => [UserLoading(), UserLoaded(testUserList)],
      verify: (_) {
        verify(mockAddUser(testUser)).called(1);
        verify(mockGetUsers()).called(1);
      },
    );

    blocTest<UserCubit, UserState>(
      'emite [UserLoading, UserError] cuando addUser lanza una excepción',
      build: () {
        when(mockAddUser(testUser)).thenThrow(Exception('Error al agregar usuario'));
        return userCubit;
      },
      act: (cubit) => cubit.createUser(testUser),
      expect: () => [UserLoading(), UserError('Error al agregar el usuario: Exception: Error al agregar usuario')],
      verify: (_) {
        verify(mockAddUser(testUser)).called(1);
      },
    );
  });

  group('removeUser', () {
    blocTest<UserCubit, UserState>(
      'emite [UserLoading, UserLoaded] cuando deleteUser tiene éxito',
      build: () {
        when(mockDeleteUser(testUser.id)).thenAnswer((_) async => {});
        when(mockGetUsers()).thenAnswer((_) async => testUserList);
        return userCubit;
      },
      act: (cubit) => cubit.removeUser(testUser.id),
      expect: () => [UserLoading(), UserLoaded(testUserList)],
      verify: (_) {
        verify(mockDeleteUser(testUser.id)).called(1);
        verify(mockGetUsers()).called(1);
      },
    );

    blocTest<UserCubit, UserState>(
      'emite [UserLoading, UserError] cuando deleteUser lanza una excepción',
      build: () {
        when(mockDeleteUser(testUser.id)).thenThrow(Exception('Error al eliminar usuario'));
        return userCubit;
      },
      act: (cubit) => cubit.removeUser(testUser.id),
      expect: () => [UserLoading(), UserError('Error al eliminar el usuario: Exception: Error al eliminar usuario')],
      verify: (_) {
        verify(mockDeleteUser(testUser.id)).called(1);
      },
    );
  });
}
