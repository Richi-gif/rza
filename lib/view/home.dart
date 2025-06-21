import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktikum_1/application/money/money_bloc.dart';
import 'package:praktikum_1/application/money/money_state.dart';
import 'package:praktikum_1/application/money/money_event.dart';
import 'package:praktikum_1/widget/moneycrud.dart';
import 'package:praktikum_1/widget/navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💸 Money Tracker'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MoneyCrudPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoneyBloc, MoneyState>(
          builder: (context, state) {
            if (state is MoneyLoaded) {
              if (state.transactions.isEmpty) {
                return const Center(child: Text('No transactions yet.'));
              }
              return ListView.builder(
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  final tx = state.transactions[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        tx.description,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: tx.type == 'in' ? Colors.green : Colors.red,
                        ),
                      ),
                      subtitle: Text(
                        '${tx.type.toUpperCase()} \RP.${tx.amount}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MoneyCrudPage(transaction: tx),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => context
                                .read<MoneyBloc>()
                                .add(DeleteTransaction(tx.id)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 0),
    );
  }
}
