import 'package:dio/dio.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/transaction.dart';

class RemoteDataSource {
  final dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api/'));

  Future<DataTransaction> getTransaction() async {
    final response = await dio.get('all_transaksi');
    return DataTransaction.fromJson(response.data);
  }
}