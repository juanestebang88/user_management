import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/datasources/hive_user_data_source.dart';
import 'data/models/address_model.dart';
import 'data/models/user_model.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/entities/user.dart';
import 'domain/usecases/add_user.dart';
import 'domain/usecases/delete_user.dart';
import 'domain/usecases/get_users.dart';
import 'presentation/cubit/user_cubit.dart';
import 'presentation/screens/user_edit_screen.dart';
import 'presentation/screens/user_form_screen.dart';
import 'presentation/screens/user_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(AddressModelAdapter());

  final userBox = await Hive.openBox<UserModel>('userBox');

  runApp(MyApp(userBox: userBox));
}

class MyApp extends StatelessWidget {
  final Box<UserModel> userBox;

  const MyApp({super.key, required this.userBox});

  @override
  Widget build(BuildContext context) {
    final hiveUserDataSource = HiveUserDataSource(userBox);
    final userRepository = UserRepositoryImpl(hiveUserDataSource);
    final getUsers = GetUsers(userRepository);
    final addUser = AddUser(userRepository);
    final deleteUser = DeleteUser(userRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserCubit(
            getUsers: getUsers,
            addUser: addUser,
            deleteUser: deleteUser,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestión de Usuarios',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.white),
        initialRoute: '/',
        routes: {
          '/': (context) => const UserListScreen(),
          '/userForm': (context) => const UserFormScreen(),
          '/userEdit': (context) => UserEditScreen(
              user: ModalRoute.of(context)!.settings.arguments as User),
        },
      ),
    );
  }
}