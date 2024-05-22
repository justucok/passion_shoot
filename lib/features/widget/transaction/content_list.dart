import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/api/apiservices.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

import '../../../api/datatransaction.dart';

class ContentList extends StatefulWidget {
  const ContentList({
    super.key,
  });

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  Service serviceAPI = Service();
  late Future<List<cData>> listData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listData = serviceAPI.getallTransaction();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double contentWidth = screenWidth * 0.9; // 90% dari lebar layar
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(9),
        ),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      width: contentWidth,
      child: FutureBuilder<List<cData>>(
        future: serviceAPI.getallTransaction(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<cData> isiData = snapshot.data!;
            return ListView.builder(
              itemCount: isiData.length,
              itemBuilder: (context, index) {
                // Mengambil data dari objek cData
                final cData data = isiData[index];
                return ListTile(
                  title: Text(
                    data.ctitle, // Menggunakan title dari cData
                    style: primaryTextStyle,
                  ),
                  subtitle: Text(
                    data.cdescription, // Menggunakan description dari cData
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: Text(
                    '${data.ctypeid == '1' || data.ctypeTransaksi == 'Pemasukan' ? '+' : '-'} ${cData.addDotToNumber(data.camount)}',
                    style: primaryTextStyle.copyWith(
                      color: data.ctypeid == '1' ||
                              data.ctypeTransaksi == 'Pemasukan'
                          ? succesColor
                          : dangerColor,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
