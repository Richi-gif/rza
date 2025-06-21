import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktikum_1/service/money/db_helper.dart';
import 'money_event.dart';
import 'money_state.dart';

class MoneyBloc extends Bloc<MoneyEvent, MoneyState> {
  MoneyBloc() : super(MoneyInitial()) {
    on<LoadTransactions>((event, emit) {
      emit(MoneyLoaded(DBHelper.getAll()));
    });

    on<AddTransaction>((event, emit) {
      DBHelper.insert(event.transaction);
      add(LoadTransactions());
    });

    on<UpdateTransaction>((event, emit) {
      DBHelper.update(event.transaction);
      add(LoadTransactions());
    });

    on<DeleteTransaction>((event, emit) {
      DBHelper.delete(event.id);
      add(LoadTransactions());
    });
  }
}
