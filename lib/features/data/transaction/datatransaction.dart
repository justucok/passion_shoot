class cData {
  String cid;
  String ctypeid;
  String cpaymentid;
  String camount;
  String ctitle;
  String cdescription;
  String ctypeTransaksi;
  String cmethod;

  cData({
    required this.cid,
    required this.ctypeid,
    required this.cpaymentid,
    required this.camount,
    required this.ctitle,
    required this.cdescription,
    this.ctypeTransaksi = '', // Nilai default
    this.cmethod = '', // Nilai default
  });

  @override
  String toString() {
    return 'cData {'
        '\n  cid: $cid,'
        '\n  ctypeid: $ctypeid,'
        '\n  cpaymentid: $cpaymentid,'
        '\n  camount: ${addDotToNumber(camount)},' // Menggunakan addDotToNumber
        '\n  ctitle: $ctitle,'
        '\n  cdescription: $cdescription,'
        '\n  ctypeTransaksi: $ctypeTransaksi,'
        '\n  cmethod: $cmethod'
        '\n}';
  }

  factory cData.fromJson(Map<String, dynamic> json) {
    return cData(
      cid: json['id'].toString(),
      ctypeid: json['typeid'].toString(),
      cpaymentid: json['paymentid'].toString(),
      camount: json['amount'].toString(),
      ctitle: json['title'],
      cdescription: json['description'],
      ctypeTransaksi: json['type']['type_transaksi'],
      cmethod: json['payment'] != null ? json['payment']['method'] : '',
    );
  }

  static String addDotToNumber(String numberString) {
    String result = '';
    int count = 0;

    for (int i = numberString.length - 1; i >= 0; i--) {
      result = numberString[i] + result;
      count++;
      if (count % 3 == 0 && i != 0) {
        result = '.' + result;
      }
    }

    return result;
  }

  Object? toJson() {}
}
