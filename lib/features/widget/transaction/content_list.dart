// import 'package:flutter/material.dart';
// import 'package:proj_passion_shoot/Provider/date_provider.dart';
// import 'package:proj_passion_shoot/features/data/datasource/api_service.dart';
// import 'package:proj_passion_shoot/config/theme/app_theme.dart';
// import 'package:proj_passion_shoot/features/data/model/transaction/get_transaction.dart';
// import 'package:provider/provider.dart';

// class ContentList extends StatefulWidget {
//   const ContentList({super.key});

//   @override
//   State<ContentList> createState() => _ContentListState();
// }

// class _ContentListState extends State<ContentList> {
//   // Service serviceAPI = Service();

//   @override
//   Widget build(BuildContext context) {
//     // final DateProvider dateProvider = Provider.of<DateProvider>(context);
//     double screenWidth = MediaQuery.of(context).size.width;
//     double contentWidth = screenWidth * 0.9; // 90% dari lebar layar

//     return Container(
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: const BorderRadius.all(
//           Radius.circular(9),
//         ),
//       ),
//       margin: const EdgeInsets.symmetric(horizontal: 12),
//       width: contentWidth,
//       child: FutureBuilder<List<TransactionData>>(
//         future: serviceAPI.getdateallTransaction(dateProvider
//             .selectedDate), // Assuming your API can take a date parameter
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<TransactionData> isiData = snapshot.data!;
//             return ListView.builder(
//               itemCount: isiData.length,
//               itemBuilder: (context, index) {
//                 final TransactionData data = isiData[index];
//                 return ListTile(
//                   //TITLE DARI ITEM
//                   title: Text(
//                     data.ctitle, // Menggunakan title dari TransactionData
//                     style: primaryTextStyle,
//                   ),
//                   //Keterangan DARI ITEM
//                   subtitle: Text(
//                     data.cdescription, // Menggunakan description dari TransactionData
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                   //Jumlah Uang DARI ITEM
//                   trailing: Text(
//                     '${data.ctypeid == '1' || data.ctypeTransaksi == 'Pemasukan' ? '+' : '-'} ${TransactionData.addDotToNumber(data.camount)}',
//                     style: primaryTextStyle.copyWith(
//                       color: data.ctypeid == '1' ||
//                               data.ctypeTransaksi == 'Pemasukan'
//                           ? succesColor
//                           : dangerColor,
//                       fontSize: 14,
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text("${snapshot.error}");
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }
