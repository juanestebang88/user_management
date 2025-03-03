import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final List<Map<String, String>>? addresses;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    this.addresses,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, birthDate, addresses];
}
