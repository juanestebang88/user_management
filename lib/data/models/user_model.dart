import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';
import 'address_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final DateTime birthDate;

  @HiveField(4)
  final List<AddressModel> addresses;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.addresses,
  });

  User toEntity() => User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        addresses: addresses.map((e) => {'street': e.street, 'city': e.city}).toList(),
      );

  static UserModel fromEntity(User user) => UserModel(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        birthDate: user.birthDate,
        addresses: user.addresses
            ?.map((e) => AddressModel(street: e['street'] ?? '', city: e['city'] ?? ''))
            .toList() ??
            [],
      );
}