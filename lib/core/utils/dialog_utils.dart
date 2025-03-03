import 'package:flutter/material.dart';

import '../../presentation/widgets/button_widget.dart';
import '../../presentation/widgets/textform_widget.dart';
import '../theme/app_colors.dart';

Future<void> showAddressDialog({
  required BuildContext context,
  required void Function(String street, String city) onSave,
}) async {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'Agregar Dirección',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormApp(
            controller: streetController,
            label: 'Dirección',
            validate: true,
          ),
          TextFormApp(
            controller: cityController,
            label: 'Ciudad',
            validate: true,
          ),
        ],
      ),
      actions: [
        ButtonApp(
          onTap: () => Navigator.pop(context),
          text: 'Cancelar',
          size: 10,
          colorButton: ColorApp.blue,
          colorText: ColorApp.white,
        ),
        ButtonApp(
          text: 'Guardar',
          size: 10,
          colorButton: ColorApp.green,
          colorText: ColorApp.white,
          onTap: () {
            final street = streetController.text.trim();
            final city = cityController.text.trim();
            if (street.isNotEmpty && city.isNotEmpty) {
              onSave(street, city);
              Navigator.pop(context);
            }
          },
        ),
      ],
    ),
  );
}
