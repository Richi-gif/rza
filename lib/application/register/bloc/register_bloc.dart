// pratikum/applications/register/bloc/register_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:praktikum_1/application/register/bloc/register_event.dart';
import 'package:praktikum_1/application/register/bloc/register_state.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUserRequested>(_onRegisterUserRequested);
  }

  Future<void> _onRegisterUserRequested(
    RegisterUserRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Update user's display name if provided
      if (event.name != null && event.name!.isNotEmpty) {
        await userCredential.user?.updateDisplayName(event.name);
      }

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'Kata sandi terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Email sudah terdaftar untuk akun lain.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Format email tidak valid.';
      } else {
        errorMessage = e.message ?? 'Terjadi kesalahan registrasi.';
      }
      emit(RegisterFailure(error: errorMessage));
    } catch (e) {
      emit(RegisterFailure(error: 'Terjadi kesalahan tidak terduga: ${e.toString()}'));
    }
  }
}