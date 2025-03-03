import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/dialog_utils.dart';
import '../cubit/user_cubit.dart';
import '../../domain/entities/user.dart';
import '../widgets/button_widget.dart';
import '../widgets/textform_widget.dart';

class UserEditScreen extends StatefulWidget {
  final User user;

  const UserEditScreen({super.key, required this.user});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _birthDateController;
  late List<Map<String, String>> _addresses;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _birthDateController = TextEditingController(
      text: widget.user.birthDate.toIso8601String().substring(0, 10),
    );
    _addresses = widget.user.addresses ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.blue,
        title: const TextTitleApp(
          text: 'Editar Usuario',
          color: ColorApp.white,
          size: 25,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormApp(
                controller: _firstNameController,
                label: 'Nombre',
                validate: true,
              ),
              TextFormApp(
                controller: _lastNameController,
                label: 'Apellido',
                validate: true,
              ),
              TextFormApp(
                label: 'Fecha de Nacimiento',
                controller: _birthDateController,
                readOnly: true,
                onTap: () async {
                  final DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (selectedDate != null) {
                    final String formattedDate =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                    _birthDateController.text = formattedDate;
                  }
                },
                validate: true,
              ),
              const SizedBox(height: 16),
              const TextTitleApp(text: 'Direcciones', size: 25,),
              Expanded(
                child: ListView.builder(
                  itemCount: _addresses.length,
                  itemBuilder: (context, index) {
                    final address = _addresses[index];
                    return ListTile(
                      title: TextTitleApp(text: address['street'] ?? '',size: 16,),
                      subtitle: TextNormalApp(text: address['city'] ?? '',size: 16,),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: ColorApp.red),
                        onPressed: () {
                          setState(() {
                            _addresses.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ButtonApp(
                text: 'Agregar Dirección',
                colorButton: ColorApp.grey,
                colorText: ColorApp.white,
                size: 16,
                onTap: ()async{
                  await showAddressDialog(
                      context: context,
                      onSave: (String street, String city) {
                        setState(() {
                          _addresses.add({'street': street, 'city': city});
                        });
                      });
                },
              ),
              const SizedBox(height: 16),
              ButtonApp(
                text: 'Guardar Usuario',
                colorButton: ColorApp.green,
                colorText: ColorApp.white,
                size: 20,
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final updatedUser = User(
                      id: widget.user.id,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      birthDate: DateTime.parse(_birthDateController.text),
                      addresses: _addresses,
                    );
                    context.read<UserCubit>().createUser(updatedUser);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

//   Future<Map<String, String>?> _showAddressDialog() async {
//     final TextEditingController streetController = TextEditingController();
//     final TextEditingController cityController = TextEditingController();

//     return await showDialog<Map<String, String>>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Agregar Dirección"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: streetController,
//                 decoration: const InputDecoration(labelText: "Calle"),
//               ),
//               TextFormField(
//                 controller: cityController,
//                 decoration: const InputDecoration(labelText: "Ciudad"),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Cancelar"),
//             ),
//             TextButton(
//               onPressed: () {
//                 final street = streetController.text.trim();
//                 final city = cityController.text.trim();
//                 if (street.isNotEmpty && city.isNotEmpty) {
//                   Navigator.pop(context, {'street': street, 'city': city});
//                 }
//               },
//               child: const Text("Guardar"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _birthDateController.dispose();
//     super.dispose();
//   }
}
