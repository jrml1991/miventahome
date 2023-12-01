import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'blocs/blocs.dart';
import 'pages/pages.dart';
import 'services/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await initializeService();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => PermissionBloc(),
    ),
    BlocProvider(
      create: (context) => NetworkInfoBloc(),
    ),
    BlocProvider(
      create: (context) => SpeedTestBloc(),
    ),
    BlocProvider(
      create: (context) => AuthBloc(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UsuarioService()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
      ),
    );
  }
}
