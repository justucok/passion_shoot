class TransactionBody {
  final int typeid;
  final int paymentid;
  final double amount;
  final String date;
  final String title;
  final String description;

  TransactionBody(
      {required this.typeid,
      required this.paymentid,
      required this.amount,
      required this.date,
      required this.title,
      required this.description,});

  Map<String,dynamic> toJson() => {
    'typeid': typeid,
    'paymentid': paymentid,
    'amount': amount,
    'date': date,
    'title': title,
    'description': description,
  };
}
