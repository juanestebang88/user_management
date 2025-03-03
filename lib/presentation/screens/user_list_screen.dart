import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management/presentation/widgets/button_widget.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import '../widgets/card_widget.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().loadUsers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.blue,
        title: const TextTitleApp(
          text: 'Lista Usuarios',
          color: ColorApp.white,
          size: 25,
        ),
      ),
      floatingActionButton: ButtonApp(
        onTap: () => Navigator.pushNamed(context, '/userForm'),
        text: 'Registrar',
        size: 16,
        colorButton: ColorApp.green,
        colorText: ColorApp.white,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: ColorApp.blue,
            ));
          } else if (state is UserLoaded) {
            final users = state.users;

            if (users.isEmpty) {
              return const Center(
                  child: TextNormalApp(text: 'No hay usuarios disponibles'));
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return CardApp(user: user);
              },
            );
          } else if (state is UserError) {
            return Center(child: TextNormalApp(text: state.message));
          }

          return const Center(child: TextNormalApp(text: 'Cargando...'));
        },
      ),
    );
  }
}
