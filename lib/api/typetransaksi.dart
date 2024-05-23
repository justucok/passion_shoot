class typeTransaksiData {
  String cid;
  String ctype_transaksi;

  typeTransaksiData({
    required this.cid,
    required this.ctype_transaksi,
  });

  factory typeTransaksiData.fromJson(Map<String, dynamic> json) {
    return typeTransaksiData(
      cid: json['id'].toString(),
      ctype_transaksi: json['type_transaksi'],
    );
  }

  static List<typeTransaksiData> parseDataListtype(dynamic json) {
    if (json['success'] == true &&
        json['data'] != null &&
        json['data']['data'] is List) {
      var list = json['data']['data'] as List;
      List<typeTransaksiData> dataList =
          list.map((data) => typeTransaksiData.fromJson(data)).toList();
      return dataList;
    } else {
      throw Exception('Invalid JSON structure');
    }
  }
}
