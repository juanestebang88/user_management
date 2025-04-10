// Mocks generated by Mockito 5.4.4 from annotations
// in user_management/test/presentation/cubit/user_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:user_management/domain/entities/user.dart' as _i5;
import 'package:user_management/domain/repositories/user_repository.dart'
    as _i2;
import 'package:user_management/domain/usecases/add_user.dart' as _i6;
import 'package:user_management/domain/usecases/delete_user.dart' as _i7;
import 'package:user_management/domain/usecases/get_users.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUserRepository_0 extends _i1.SmartFake
    implements _i2.UserRepository {
  _FakeUserRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetUsers].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUsers extends _i1.Mock implements _i3.GetUsers {
  MockGetUsers() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);

  @override
  _i4.Future<List<_i5.User>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i4.Future<List<_i5.User>>.value(<_i5.User>[]),
      ) as _i4.Future<List<_i5.User>>);
}

/// A class which mocks [AddUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddUser extends _i1.Mock implements _i6.AddUser {
  MockAddUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);

  @override
  _i4.Future<void> call(_i5.User? user) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [user],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [DeleteUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteUser extends _i1.Mock implements _i7.DeleteUser {
  MockDeleteUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);

  @override
  _i4.Future<void> call(String? userId) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [userId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
