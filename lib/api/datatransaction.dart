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
    required this.ctypeTransaksi,
    required this.cmethod,
  });

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

  List<cData> parseDataList(dynamic json) {
    var list = json['data'] as List;
    List<cData> dataList = list.map((data) => cData.fromJson(data)).toList();
    return dataList;
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
