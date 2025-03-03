import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:user_management/domain/entities/user.dart';
import 'package:user_management/domain/repositories/user_repository.dart';
import 'package:user_management/domain/usecases/add_user.dart';
import 'package:user_management/domain/usecases/delete_user.dart';
import 'package:user_management/domain/usecases/get_users.dart';

import 'user_usecases_test.mocks.dart';

// Generar el mock para UserRepository
@GenerateMocks([UserRepository])
void main() {
  // Declaramos las variables necesarias
  late MockUserRepository mockUserRepository;
  late GetUsers getUsers;
  late AddUser addUser;
  late DeleteUser deleteUser;

  // Inicialización antes de cada prueba
  setUp(() {
    mockUserRepository = MockUserRepository();
    getUsers = GetUsers(mockUserRepository);
    addUser = AddUser(mockUserRepository);
    deleteUser = DeleteUser(mockUserRepository);
  });

  group('GetUsers UseCase', () {
    test('debería obtener la lista de usuarios del repositorio', () async {
      // Datos de prueba
      final users = [
        User(
          id: '1',
          firstName: 'John',
          lastName: 'Doe',
          birthDate: DateTime(1990, 1, 1),
        ),
      ];

      // Configuración del mock
      when(mockUserRepository.getUsers()).thenAnswer((_) async => users);

      // Ejecución
      final result = await getUsers();

      // Verificación
      expect(result, users);
      verify(mockUserRepository.getUsers()).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });
  });

  group('AddUser UseCase', () {
    test('debería agregar un usuario al repositorio', () async {
      // Datos de prueba
      final user = User(
        id: '1',
        firstName: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
      );

      // Configuración del mock
      when(mockUserRepository.addUser(user)).thenAnswer((_) async => {});

      // Ejecución
      await addUser(user);

      // Verificación
      verify(mockUserRepository.addUser(user)).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });
  });

  group('DeleteUser UseCase', () {
    test('debería eliminar un usuario por ID del repositorio', () async {
      // Datos de prueba
      const userId = '1';

      // Configuración del mock
      when(mockUserRepository.deleteUser(userId)).thenAnswer((_) async => {});

      // Ejecución
      await deleteUser(userId);

      // Verificación
      verify(mockUserRepository.deleteUser(userId)).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
