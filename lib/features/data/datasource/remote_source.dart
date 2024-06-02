import 'package:dio/dio.dart';

import '../model/transaction/transaction.dart';

class RemoteDataSource {
  final dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api/'));

  Future<DataTransaksi> getTransaksi() async {
    final response = await dio.get('/all_transaksi');
    if (response.statusCode == 200) {
      return DataTransaksi.fromJson(response.data);
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<void> postTransaksi(DataTransaksi dataTransaksi) async {
    try {
      final response =
          await dio.post('/all_transaksi', data: dataTransaksi.toJson());
      if (response.statusCode == 201) {
        // Berhasil melakukan posting data
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
