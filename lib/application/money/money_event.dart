import 'package:equatable/equatable.dart';
import 'package:praktikum_1/service/money/money_model.dart';

abstract class MoneyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTransactions extends MoneyEvent {}

class AddTransaction extends MoneyEvent {
  final MoneyTransaction transaction;
  AddTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class UpdateTransaction extends MoneyEvent {
  final MoneyTransaction transaction;
  UpdateTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class DeleteTransaction extends MoneyEvent {
  final String id;
  DeleteTransaction(this.id);

  @override
  List<Object?> get props => [id];
}
