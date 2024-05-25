class acData {
  String cid;
  String cmethod;

  acData({
    required this.cid,
    required this.cmethod,
  });

  factory acData.fromJson(Map<String, dynamic> json) {
    return acData(
      cid: json['id'].toString(),
      cmethod: json['method'],
    );
  }

  static List<acData> parseDataListacc(dynamic json) {
    if (json['success'] == true &&
        json['data'] != null &&
        json['data']['data'] is List) {
      var list = json['data']['data'] as List;
      List<acData> dataList =
          list.map((data) => acData.fromJson(data)).toList();
      return dataList;
    } else {
      throw Exception('Invalid JSON structure');
    }
  }
}
