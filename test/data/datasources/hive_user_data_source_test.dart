import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:hive/hive.dart';
import 'package:user_management/data/datasources/hive_user_data_source.dart';
import 'package:user_management/data/models/user_model.dart';
import 'package:user_management/domain/entities/user.dart';

import 'hive_user_data_source_test.mocks.dart';

// Generar el mock para la caja de Hive
@GenerateMocks([Box])
void main() {
  // Declaramos las variables necesarias
  late MockBox<UserModel> mockUserBox;
  late HiveUserDataSource hiveUserDataSource;

  // Datos de prueba
  final testUserModel = UserModel(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    birthDate: DateTime(1990, 1, 1),
    addresses: [],
  );

  final testUser = User(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    birthDate: DateTime(1990, 1, 1),
    addresses: [],
  );

  setUp(() {
    mockUserBox = MockBox<UserModel>();
    hiveUserDataSource = HiveUserDataSource(mockUserBox);
  });

  group('fetchUsers', () {
    test('debería obtener la lista de usuarios desde la caja de Hive', () async {
      // Configuración del mock
      when(mockUserBox.values).thenReturn([testUserModel]);

      // Ejecución
      final result = await hiveUserDataSource.fetchUsers();

      // Verificación
      expect(result, [testUser]); // Compara entidades `User`
      verify(mockUserBox.values).called(1);
      verifyNoMoreInteractions(mockUserBox);
    });
  });

  group('saveUser', () {
    test('debería guardar un usuario en la caja de Hive', () async {
      // Configuración del mock
      when(mockUserBox.put(testUser.id, testUserModel)).thenAnswer((_) async => {});

      // Ejecución
      await hiveUserDataSource.saveUser(testUser);

      // Verificación
      verify(mockUserBox.put(testUser.id, testUserModel)).called(1);
      verifyNoMoreInteractions(mockUserBox);
    });
  });

  group('deleteUser', () {
    test('debería eliminar un usuario por ID desde la caja de Hive', () async {
      // Configuración del mock
      when(mockUserBox.delete(testUser.id)).thenAnswer((_) async => {});

      // Ejecución
      await hiveUserDataSource.deleteUser(testUser.id);

      // Verificación
      verify(mockUserBox.delete(testUser.id)).called(1);
      verifyNoMoreInteractions(mockUserBox);
    });
  });
}
