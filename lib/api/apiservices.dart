import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:proj_passion_shoot/api/datatransaction.dart';
import 'package:proj_passion_shoot/api/bank_account.dart';

class Service {
  Future<List<cData>> getallTransaction() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/all_transaksi'));
    if (response.statusCode == 200) {
      List<cData> transactions = parseDataList(json.decode(response.body));
      return transactions;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<List<acData>> getmethodpayment() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/payment_method'));
    if (response.statusCode == 200) {
      List<acData> payments = parseDataListacc(json.decode(response.body));
      return payments;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  List<cData> parseDataList(dynamic json) {
    var list =
        json['data'] as List; // Pastikan untuk mengakses 'data' sebagai List
    List<cData> dataList = list.map((data) => cData.fromJson(data)).toList();
    return dataList;
  }

  List<acData> parseDataListacc(dynamic json) {
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
