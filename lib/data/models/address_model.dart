import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 1)
class AddressModel extends HiveObject {
  @HiveField(0)
  final String street;

  @HiveField(1)
  final String city;

  AddressModel({
    required this.street,
    required this.city,
  });

  Map<String, String> toEntity() => {
        'street': street,
        'city': city,
      };

  static AddressModel fromEntity(Map<String, String> entity) {
    return AddressModel(
      street: entity['street'] ?? '',
      city: entity['city'] ?? '',
    );
  }
}
