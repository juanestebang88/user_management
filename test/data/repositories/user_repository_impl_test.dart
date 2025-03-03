import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:user_management/data/datasources/hive_user_data_source.dart';
import 'package:user_management/data/repositories/user_repository_impl.dart';
import 'package:user_management/domain/entities/user.dart';

import 'user_repository_impl_test.mocks.dart';

// Generar el mock para HiveUserDataSource
@GenerateMocks([HiveUserDataSource])
void main() {
  // Declaramos las variables necesarias
  late MockHiveUserDataSource mockHiveUserDataSource;
  late UserRepositoryImpl userRepository;

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
    mockHiveUserDataSource = MockHiveUserDataSource();
    userRepository = UserRepositoryImpl(mockHiveUserDataSource);
  });

  group('getUsers', () {
    test('debería obtener la lista de usuarios desde el data source', () async {
      // Configuración del mock
      when(mockHiveUserDataSource.fetchUsers()).thenAnswer((_) async => testUserList);

      // Ejecución
      final result = await userRepository.getUsers();

      // Verificación
      expect(result, testUserList);
      verify(mockHiveUserDataSource.fetchUsers()).called(1);
      verifyNoMoreInteractions(mockHiveUserDataSource);
    });
  });

  group('addUser', () {
    test('debería agregar un usuario al data source', () async {
      // Configuración del mock
      when(mockHiveUserDataSource.saveUser(testUser)).thenAnswer((_) async => {});

      // Ejecución
      await userRepository.addUser(testUser);

      // Verificación
      verify(mockHiveUserDataSource.saveUser(testUser)).called(1);
      verifyNoMoreInteractions(mockHiveUserDataSource);
    });
  });

  group('deleteUser', () {
    test('debería eliminar un usuario por ID del data source', () async {
      // Configuración del mock
      when(mockHiveUserDataSource.deleteUser(testUser.id)).thenAnswer((_) async => {});

      // Ejecución
      await userRepository.deleteUser(testUser.id);

      // Verificación
      verify(mockHiveUserDataSource.deleteUser(testUser.id)).called(1);
      verifyNoMoreInteractions(mockHiveUserDataSource);
    });
  });
}
