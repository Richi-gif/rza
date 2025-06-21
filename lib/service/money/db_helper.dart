import 'dart:convert';
import 'dart:html' as web;
import 'money_model.dart';

class DBHelper {
  static const _storageKey = 'transactions';

  static List<MoneyTransaction> _getTransactions() {
    final data = web.window.localStorage[_storageKey];
    if (data != null) {
      final list = jsonDecode(data) as List;
      return list.map((e) => MoneyTransaction.fromJson(e)).toList();
    }
    return [];
  }

  static void _saveTransactions(List<MoneyTransaction> list) {
    web.window.localStorage[_storageKey] =
        jsonEncode(list.map((e) => e.toJson()).toList());
  }

  static List<MoneyTransaction> getAll() => _getTransactions();

  static void insert(MoneyTransaction transaction) {
    final list = _getTransactions();
    list.add(transaction);
    _saveTransactions(list);
  }

  static void update(MoneyTransaction transaction) {
    final list = _getTransactions();
    final index = list.indexWhere((e) => e.id == transaction.id);
    if (index != -1) list[index] = transaction;
    _saveTransactions(list);
  }

  static void delete(String id) {
    final list = _getTransactions()..removeWhere((e) => e.id == id);
    _saveTransactions(list);
  }
}
