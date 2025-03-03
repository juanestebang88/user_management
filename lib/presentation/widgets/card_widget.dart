import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_management/domain/entities/user.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/format_utils.dart';
import '../cubit/user_cubit.dart';

class CardApp extends StatelessWidget {
  const CardApp({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(AppDimensions.getBorderRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(AppDimensions.getResponsivePaddingV(context)),
      margin: EdgeInsets.all(AppDimensions.getResponsiveMargin(context)),
      child: Column(
        children: [
          TextTitleApp(
            text: '${user.firstName} ${user.lastName}',
            size: 24,
          ),
          TextNormalApp(
            text: 'Nacimiento: ${formatDate(user.birthDate)}',
            size: 18,
          ),
          const Divider(),
          TextNormalApp(
            text: getFirstAddress(user),
            size: 18,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: ColorApp.blue,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/userEdit',
                    arguments: user,
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: ColorApp.red,
                  size: 30,
                ),
                onPressed: () {
                  _showDeleteConfirmation(context, user.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _showDeleteConfirmation(BuildContext context, String userId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const TextTitleApp(
          text: 'Confirmar Eliminación',
          size: 20,
        ),
        content: const TextNormalApp(
            text: '¿Estás seguro de que deseas eliminar este usuario?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const TextNormalApp(
              text: 'Cancelar',
              color: ColorApp.green,
              size: 18,
            ),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<UserCubit>()
                  .removeUser(userId);
              Navigator.pop(context);
            },
            child: const TextNormalApp(
              text: 'Eliminar',
              color: ColorApp.red,
              size: 18,
            ),
          ),
        ],
      );
    },
  );
}
