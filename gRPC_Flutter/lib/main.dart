import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_flutter/repo/user_repo.dart';
import 'package:grpc_flutter/users/view/users_route.dart';
import 'package:users_api/users_api.dart';

import 'bootstrap.dart';

void main() {
  bootstrap(() async {
    const baseUrl = String.fromEnvironment('API_URL');
    final port = int.tryParse(const String.fromEnvironment('API_PORT')) ?? 8080;

    final apiClient = ApiClient(
      baseUrl: baseUrl,
      port: port,
    );

    final usersRepository = UsersRepository(apiClient: apiClient);

    return App(
      usersRepository: usersRepository,
    );
  });
}

class App extends StatelessWidget {
  const App({
    super.key,
    required usersRepository,
  }) : _usersRepository = usersRepository;

  final UsersRepository _usersRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _usersRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Users Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UsersRoute(),
    );
  }
}