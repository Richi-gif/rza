import 'package:equatable/equatable.dart';
import 'package:praktikum_1/service/money/money_model.dart';

abstract class MoneyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MoneyInitial extends MoneyState {}

class MoneyLoaded extends MoneyState {
  final List<MoneyTransaction> transactions;

  MoneyLoaded(this.transactions);

  @override
  List<Object?> get props => [transactions];
}
