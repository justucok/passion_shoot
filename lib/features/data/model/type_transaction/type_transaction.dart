// ignore_for_file: non_constant_identifier_names

class TypeTransaksiData {
  String id;
  String type_transaction;

  TypeTransaksiData({
    required this.id,
    required this.type_transaction,
  });

  factory TypeTransaksiData.fromJson(Map<String, dynamic> json) {
    return TypeTransaksiData(
      id: json['id'].toString(),
      type_transaction: json['type_transaksi'],
    );
  }

  static List<TypeTransaksiData> parseDataListtype(dynamic json) {
    if (json['success'] == true &&
        json['data'] != null &&
        json['data']['data'] is List) {
      var list = json['data']['data'] as List;
      List<TypeTransaksiData> dataList =
          list.map((data) => TypeTransaksiData.fromJson(data)).toList();
      return dataList;
    } else {
      throw Exception('Invalid JSON structure');
    }
  }
}
