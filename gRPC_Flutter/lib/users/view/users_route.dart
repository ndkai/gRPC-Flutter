import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_flutter/users/view/users_view.dart';

import '../../repo/user_repo.dart';
import '../bloc/users_bloc.dart';

class UsersRoute extends StatelessWidget {
  const UsersRoute({Key? key}) : super(key: key);

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (ctx) {
        return BlocProvider(
          create: (_) => UsersBloc(
            usersRepository: context.read<UsersRepository>(),
          ),
          child: const UsersView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UsersBloc(
        usersRepository: context.read<UsersRepository>(),
      )..add(UsersFetched()),
      child: const UsersView(),
    );
  }
}
