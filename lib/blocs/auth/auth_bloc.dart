import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:miventahome/models/models.dart';
import 'package:miventahome/services/services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState(usuario: Usuario())) {
    on<OnLoginEvent>(_onLoginUsuario);
    on<OnLogoutEvent>(_onLogoutUsuario);
    on<OnCheckLoginEvent>(_onCheckLoginUsuario);
    on<OnToggleShowPassEvent>(
      (event, emit) => emit(
        state.copyWith(
          showPass: !state.showPass,
        ),
      ),
    );
    on<OnActualizarFotoEvent>(
      (event, emit) => emit(
        state.copyWith(
          usuario: state.usuario.copyWith(
            foto: event.foto,
          ),
        ),
      ),
    );
  }

  void _onLoginUsuario(OnLoginEvent event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        autenticado: false,
        procesando: true,
      ),
    );

    AuthService auth = AuthService();
    UsuarioService usuarioService = UsuarioService();

    final resp = await auth.login(event.usuario, event.password);

    if (resp) {
      final token = await auth.getToken();
      final tokenExpiration = await auth.getTokenExp();
      final usuario = await usuarioService.getInfoUsuario();

      emit(
        state.copyWith(
          usuario: usuario,
          autenticado: true,
          fallido: false,
          intentos: 0,
          token: token,
          expirationDate: DateTime.parse(tokenExpiration),
          procesando: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          autenticado: false,
          fallido: true,
          intentos: state.intentos + 1,
          procesando: false,
        ),
      );
    }
  }

  void _onLogoutUsuario(OnLogoutEvent event, Emitter<AuthState> emit) async {
    AuthService _auth = AuthService();

    await _auth.logOut();
    emit(
      state.copyWith(
        autenticado: false,
        fallido: false,
        intentos: 0,
        procesando: false,
      ),
    );
  }

  void _onCheckLoginUsuario(
      OnCheckLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      autenticado: false,
      fallido: false,
      intentos: 0,
      checkLoginFinish: false,
    ));
    final authService = AuthService();
    final usuarioService = UsuarioService();

    String expTS = await authService.getTokenExp();
    String token = await authService.getToken();

    final fechaExp =
        DateTime.fromMillisecondsSinceEpoch(int.parse(expTS) * 1000);

    final fechaActual = DateTime.now();

    if (fechaActual.compareTo(fechaExp) <= 0) {
      final usuario = await usuarioService.getInfoUsuario();
      emit(state.copyWith(
        autenticado: true,
        fallido: false,
        intentos: 0,
        usuario: usuario,
        expirationDate: fechaExp,
        token: token,
        checkLoginFinish: true,
      ));
    } else {
      emit(
        state.copyWith(
          autenticado: false,
          fallido: false,
          intentos: 0,
          checkLoginFinish: true,
        ),
      );
    }
  }
}
