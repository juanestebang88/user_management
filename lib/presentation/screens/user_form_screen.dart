import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user_management/core/theme/app_colors.dart';
import 'package:user_management/core/theme/app_dimensions.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_text.dart';
import '../../core/utils/dialog_utils.dart';
import '../cubit/user_cubit.dart';
import '../../domain/entities/user.dart';
import '../widgets/button_widget.dart';
import '../widgets/textform_widget.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final List<Map<String, String>> _addresses = [];
  final Uuid uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.blue,
        title: const TextTitleApp(
          text: 'Crear Usuario',
          color: ColorApp.white,
          size: 25,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.getResponsivePaddingH(context)),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: AppDimensions.getResponsivePaddingV(context),
              ),
              const TextNormalApp(
                text: 'Ingrese los datos del usuario a registrar',
                size: 18,
              ),
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
              ButtonApp(
                text: 'Agregar Dirección',
                colorButton: ColorApp.grey,
                colorText: ColorApp.white,
                size: 16,
                onTap: () async {
                  await showAddressDialog(
                      context: context,
                      onSave: (String street, String city) {
                        setState(() {
                          _addresses.add({'street': street, 'city': city});
                        });
                      });
                },
              ),
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
                          setState(() => _addresses.removeAt(index));
                        },
                      ),
                    );
                  },
                ),
              ),
              ButtonApp(
                text: 'Guardar Usuario',
                colorButton: ColorApp.green,
                colorText: ColorApp.white,
                size: 20,
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final user = User(
                      id: uuid.v4(),
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      birthDate: DateTime.parse(_birthDateController.text),
                      addresses: _addresses,
                    );
                    context.read<UserCubit>().createUser(user);
                    Navigator.pop(context);
                  }
                },
              ),
              SizedBox(
                height: AppDimensions.getResponsivePaddingV(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
