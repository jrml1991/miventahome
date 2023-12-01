import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miventahome/blocs/auth/auth_bloc.dart';
import 'package:miventahome/models/usuario.dart';
import 'package:miventahome/pages/login_page.dart';
import 'package:miventahome/services/usuario_service.dart';
import 'package:miventahome/ui/app_styles.dart';
import 'package:provider/provider.dart';

class MiPerfilPage extends StatefulWidget {
  const MiPerfilPage({super.key});

  @override
  State<MiPerfilPage> createState() => _MiPerfilPageState();
}

class _MiPerfilPageState extends State<MiPerfilPage> {
  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Mi Perfil',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1BB5FD),
                    fontFamily: 'Cronos-Pro'),
              ),
            ),
          ),
          Center(
            child: FutureBuilder(
              future: usuarioService.getInfoUsuario(),
              builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Color(0xff1BB5FD),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/user_icon_cyan.png"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              )
                            ]),
                        child: Column(
                          children: [
                            buildUserInfoDisplay(
                                snapshot.data!.nombre!, "Nombre", screenWidth),
                            buildUserInfoDisplay(
                                snapshot.data!.usuario!.toLowerCase(),
                                "Usuario",
                                screenWidth),
                            buildUserInfoDisplay(
                              snapshot.data!.correo!.toLowerCase(),
                              "Correo",
                              screenWidth,
                            ),
                            buildUserInfoDisplay(
                              snapshot.data!.perfil.toString(),
                              "Perfil",
                              screenWidth,
                            ),
                            buildUserInfoDisplay(
                              snapshot.data!.idDms.toString(),
                              "Id DMS",
                              screenWidth,
                            ),
                            buildUserInfoDisplay(
                              snapshot.data!.telefono.toString(),
                              "Telefono",
                              screenWidth,
                            ),
                            buildUserInfoDisplay(
                              snapshot.data!.identidad.toString(),
                              "Identidad",
                              screenWidth,
                            ),
                            buildUserInfoDisplay(
                              snapshot.data!.territorio.toString(),
                              "Territorio",
                              screenWidth,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          authBloc.add(
                            OnLogoutEvent(),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        label: const Text(
                          "Salir",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'CronosLPro',
                            fontSize: 18,
                          ),
                        ),
                        icon: const Icon(
                          Icons.logout_rounded,
                          color: kPrimaryColor,
                          size: 18,
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 0,
            child: WillPopScope(
              onWillPop: () => _onWillPop(),
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Confirmación"),
                ),
                body: Container(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmación'),
            content: const Text('¿Desea salir de mi calle?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Si'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget buildUserInfoDisplay(
    String getValue,
    String title,
    double screenWidth,
  ) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1BB5FD),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              width: screenWidth * 0.8,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                    child: Text(
                      getValue.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
}
