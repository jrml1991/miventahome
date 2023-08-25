import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miventahome/global/environment.dart';
import 'package:miventahome/models/usuario.dart';
import 'package:miventahome/services/auth_service.dart';
import 'package:miventahome/services/db_service.dart';

import '../models/usuario_response.dart';

class UsuarioService with ChangeNotifier {
  DBService dbService = DBService();
  final AuthService _authService = AuthService();

  Future<bool> guardarUsuario() async {
    try {
      final resp = await http
          .get(Uri.parse('${Environment.apiURL}/usuario/info'), headers: {
        'Content-Type': 'application/json',
        'token': await _authService.getToken()
      });

      final usuarioResponse = usuarioResponseFromMap(resp.body);

      //eliminando usuario antes de insertar
      await dbService.deleteUsuario();

      //guardar usuario en base de datos local
      await dbService.addUsuario(usuarioResponse.usuario);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Usuario> getInfoUsuario() async {
    try {
      final usuario = await dbService.getUsuario();
      return usuario.first;
    } catch (e) {
      Usuario usuario = Usuario(
        flag: "false",
        idDms: "0",
        usuario: "0",
        nombre: "nombre2",
        identidad: "identidad",
        territorio: "territorio",
        perfil: 0,
        telefono: "telefono",
        correo: "correo",
        resultado: "fallido",
      );

      return usuario;
    }
  }
}
