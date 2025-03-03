import 'package:intl/intl.dart';

import '../../domain/entities/user.dart';

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String getFirstAddress(User user) {
  if (user.addresses != null && user.addresses!.isNotEmpty) {
    final address = user.addresses!.first;
    return 'Dirección Principal:\n  ${address['street'] ?? ''}, ${address['city'] ?? ''}';
  } else {
    return 'No tiene direccion registrada';
  }
}
