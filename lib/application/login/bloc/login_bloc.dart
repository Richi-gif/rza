import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:praktikum_1/application/login/bloc/login_event.dart';
import 'package:praktikum_1/application/login/bloc/login_state.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LoginRequest>(_onLoginRequest);
    on<LogoutRequest>(_onLogoutRequest);
  }

  Future<void> _onLoginRequest(
      LoginRequest event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      final token = await userCredential.user?.getIdToken();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_key', token ?? '');

      emit(LoginSuccess(message: 'Login berhasil'));
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Login gagal';
      if (e.code == 'user-not-found') {
        errorMessage = 'Pengguna tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Password salah';
      }
      emit(LoginFailure(error: errorMessage));
    } catch (e) {
      emit(LoginFailure(error: 'Terjadi kesalahan: ${e.toString()}'));
    }
  }

  Future<void> _onLogoutRequest(
      LogoutRequest event, Emitter<LoginState> emit) async {
    emit(LogoutLoading());
    try {
      await _auth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Tetap gunakan LoginSuccess untuk logout berhasil (dengan pesan berbeda)
      emit(LoginSuccess(message: 'Logout berhasil'));
    } catch (e) {
      emit(LogoutFailure(error: 'Logout gagal: ${e.toString()}'));
    }
  }
}
