import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktikum_1/application/money/money_bloc.dart';
import 'package:praktikum_1/application/money/money_event.dart';
import 'package:praktikum_1/service/money/money_model.dart';
import 'package:uuid/uuid.dart';

class MoneyCrudPage extends StatelessWidget {
  final MoneyTransaction? transaction;

  const MoneyCrudPage({super.key, this.transaction});

  @override
  Widget build(BuildContext context) {
    final amountController = TextEditingController(
      text: transaction != null ? transaction!.amount.toString() : '',
    );

    final descriptionController = TextEditingController(
      text: transaction?.description ?? '',
    );

    final typeController = TextEditingController(
      text: transaction?.type ?? 'in',
    );

    return Scaffold(
      appBar: AppBar(
        title:
            Text(transaction == null ? 'Add Transaction' : 'Edit Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: typeController.text,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(
                  value: 'in',
                  child: Text('Income'),
                ),
                DropdownMenuItem(
                  value: 'out',
                  child: Text('Outcome'),
                ),
              ],
              onChanged: (val) => typeController.text = val ?? 'in',
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final id = transaction?.id ?? const Uuid().v4();
                final newTransaction = MoneyTransaction(
                  id: id,
                  amount: int.tryParse(amountController.text) ?? 0,
                  description: descriptionController.text,
                  type: typeController.text,
                );

                if (transaction == null) {
                  context.read<MoneyBloc>().add(AddTransaction(newTransaction));
                } else {
                  context
                      .read<MoneyBloc>()
                      .add(UpdateTransaction(newTransaction));
                }

                Navigator.pop(context); // back to list
              },
              child: Text(transaction == null
                  ? 'Add Transaction'
                  : 'Update Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
