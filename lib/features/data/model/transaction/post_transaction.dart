class Transaction {
  final int typeid;
  final int paymentid;
  final double amount;
  final String title;
  final String description;

  Transaction({
    required this.typeid,
    required this.paymentid,
    required this.amount,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'typeid': typeid,
      'paymentid': paymentid,
      'amount': amount,
      'title': title,
      'description': description,
    };
  }
}
