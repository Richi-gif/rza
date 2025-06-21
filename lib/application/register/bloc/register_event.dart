// pratikum/applications/register/bloc/register_event.dart
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserRequested extends RegisterEvent {
  final String email;
  final String password;
  final String? name; // Name is optional for Firebase registration directly

  const RegisterUserRequested({
    required this.email,
    required this.password,
    this.name,
  });

  @override
  List<Object> get props => [email, password, name ?? ''];
}