import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:proj_passion_shoot/api/datatransaction.dart';
import 'package:proj_passion_shoot/api/bank_account.dart';
import 'package:proj_passion_shoot/api/posttransaksi.dart';
import 'package:proj_passion_shoot/api/typetransaksi.dart';

class Service {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  Future<List<cData>> getallTransaction() async {
    final response = await http.get(Uri.parse('${baseUrl}all_transaksi'));
    if (response.statusCode == 200) {
      List<cData> transactions = parseDataList(json.decode(response.body));
      return transactions;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<List<acData>> getmethodpayment() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}payment_method'));
      if (response.statusCode == 200) {
        List<acData> payments = parseDataListacc(json.decode(response.body));
        return payments;
      } else {
        throw Exception('Failed to load Data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching payment methods: $e');
      throw Exception('Failed to fetch payment methods: $e');
    }
  }

  Future<List<typeTransaksiData>> getTypeTransaksi() async {
    final response = await http.get(Uri.parse('${baseUrl}type_transaksi'));
    if (response.statusCode == 200) {
      List<typeTransaksiData> type =
          parseDataListtype(json.decode(response.body));
      return type;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<void> saveTransaction(Transaction transaction) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/all_transaksi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Berhasil menyimpan transaksi');
    } else {
      print('Gagal menyimpan transaksi: ${response.statusCode}');
      if (response.body.isNotEmpty) {
        print('Detail Kesalahan: ${response.body}');
      }
      throw Exception('Failed to save transaction');
    }
  }

  List<cData> parseDataList(dynamic json) {
    var list =
        json['data'] as List; // Pastikan untuk mengakses 'data' sebagai List
    List<cData> dataList = list.map((data) => cData.fromJson(data)).toList();
    return dataList;
  }

  List<acData> parseDataListacc(dynamic json) {
    try {
      if (json['success'] == true &&
          json['data'] != null &&
          json['data'] is List) {
        var list = json['data'] as List;
        List<acData> dataList =
            list.map((data) => acData.fromJson(data)).toList();
        return dataList;
      } else {
        throw Exception('Invalid JSON structure');
      }
    } catch (e) {
      print('Error parsing payment methods data: $e');
      throw Exception('Failed to parse payment methods data: $e');
    }
  }

  List<typeTransaksiData> parseDataListtype(dynamic json) {
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
