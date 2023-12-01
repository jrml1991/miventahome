import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miventahome/blocs/blocs.dart';
import 'package:miventahome/pages/login_page.dart';
import 'package:miventahome/pages/pages.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PermissionBloc, PermissionState>(
        builder: (context, state) {
          if (!state.isAllGranted) {
            return const GpsAccessPage();
          }

          return const LoginPage();
        },
      ),
    );
  }
}
