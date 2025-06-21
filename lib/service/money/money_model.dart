class MoneyTransaction {
  final String id;
  final int amount;
  final String description;
  final String type; // "in" or "out"

  MoneyTransaction({required this.id, required this.amount, required this.description, required this.type});

  factory MoneyTransaction.fromJson(Map<String, dynamic> json) => MoneyTransaction(
        id: json['id'],
        amount: json['amount'],
        description: json['description'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'description': description,
        'type': type,
      };
}
