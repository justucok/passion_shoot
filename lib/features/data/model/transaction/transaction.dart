class DataTransaction {
  final List<Transaction> data;

  DataTransaction({required this.data});

  factory DataTransaction.fromJson(Map<String, dynamic> json) =>
      DataTransaction(
        data: List.from(json['data'].map((transaction) => Transaction.fromModel(transaction))),
      );
}

class Transaction {
  final int id;
  final int typeid;
  final int paymentid;
  final int amount;
  final String title;
  final String description;

  Transaction({
    required this.id,
    required this.typeid,
    required this.paymentid,
    required this.amount,
    required this.title,
    required this.description,
  });

  factory Transaction.fromModel(Map<String, dynamic> json) => Transaction(
        id: json['id'],
        typeid: json['typeid'],
        paymentid: json['paymentid'],
        amount: json['amount'],
        title: json['title'],
        description: json['description'],
      );
}
