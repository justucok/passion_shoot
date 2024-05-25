class AddPaymentMethod {
  final String method;

  AddPaymentMethod({required this.method});

  Map<String, dynamic> toJson() {
    return {
      'method': method,
    };
  }
}
