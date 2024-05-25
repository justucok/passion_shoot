import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/features/data/Payment/addpayment.dart';
import 'package:proj_passion_shoot/features/data/event_calender/event.dart';
import 'package:proj_passion_shoot/features/data/transaction/datatransaction.dart';
import 'package:proj_passion_shoot/features/data/Payment/bank_account.dart';
import 'package:proj_passion_shoot/features/data/transaction/posttransaksi.dart';
import 'package:proj_passion_shoot/features/data/Type_transaction/typetransaksi.dart';

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

  Future<List<cData>> getdateallTransaction(DateTime selectedDate) async {
    final response = await http.get(Uri.parse(
        '${baseUrl}all_transaksi?date=${selectedDate.toIso8601String()}'));

    if (response.statusCode == 200) {
      List<cData> transactions = parseDataList(json.decode(response.body));
      return transactions;
    } else {
      throw Exception('Failed to load transactions');
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

  //POST PAYMENTMETHOD
  Future<void> savePaymentMethod(AddPaymentMethod paymentMethod) async {
    final response = await http.post(
      Uri.parse('${baseUrl}payment_method'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(paymentMethod.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Berhasil menyimpan payment method');
    } else if (response.statusCode == 409) {
      throw Exception('Payment method already exists');
    } else {
      print('Gagal menyimpan payment method: ${response.statusCode}');
      if (response.body.isNotEmpty) {
        print('Detail Kesalahan: ${response.body}');
      }
      throw Exception('Failed to save payment method');
    }
  }

  //POST PENAMBAHAN TRANSAKSI
  Future<void> saveTransaction(Transaction transaction) async {
    final response = await http.post(
      Uri.parse('${baseUrl}all_transaksi'),
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

  //EVENT

  Future<List<Event>> getEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/event'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<void> createEvent(Event event) async {
    final response = await http.post(
      Uri.parse('${baseUrl}event'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(event.toJson()),
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
    if (json['data'] is List) {
      var list = json['data'] as List;
      return list.map((data) => cData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to parse data: JSON is not a list');
    }
  }

  List<acData> parseDataListacc(dynamic json) {
    if (json['success'] == true && json['data'] is List) {
      var list = json['data'] as List;
      return list.map((data) => acData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to parse payment methods data');
    }
  }

  List<typeTransaksiData> parseDataListtype(dynamic json) {
    if (json['success'] == true && json['data']['data'] is List) {
      var list = json['data']['data'] as List;
      return list.map((data) => typeTransaksiData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to parse type transactions data');
    }
  }
}
