import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class PageList extends StatelessWidget {
//   List<String> nama_bumn = [
//     "PT Perusahaan Listrik Negara (Persero)",
//     "PT Telkom Indonesia (Persero)",
//     "PT Pertamina Persero",
//     "Indonesia Tourism Development Corporation",
//     "LKBN Antarax",
//     "INALUM",
//     "Pupuk Indonesia",
//     "Semen Indonesia",
//     "PTPN",
//     "Bio Farma",
//     "Rajawali Nusantara Indonesia",
//     "Garuda Indonesia",
//     "Angkasa Pura 1",
//     "Angkasa Pura 2",
//     "ASDP Indonesia Ferry",
//     "Jasamarga",
//     "Kereta Api Indonesia",
//     "Pelabuhan Indonesia 1",
//     "Pelabuhan Indonesia 2",
//     "Pelabuhan Indonesia 3",
//     "Pelabuhan Indonesia 4",
//     "Pelayaran Indonesia",
//     "Bulog",
//     "Bhanda Ghara Reksa",
//     "Pos Indonesia",
//     "Bank Negara Indonesia",
//     "Bank Mandiri",
//     "Bank Rakyat Indonesia",
//     "Bank Tabungan Negara",
//     "Permodalan Nasional Madani",
//     "Pengadaian",
//     "Asuransi Kredit Indonesia",
//     "Jamkrindo",
//   ];

//   List<Widget> _listPage = [
//     new PLN(),
//     new TelkomIndonesia(),
//     new Pertamina(),
//     new ITDC(),
//     new Antara(),
//     new Inalum(),
//     new PupukIndonesia(),
//     new SemenIndonesia(),
//     new PTPN(),
//     new BioFarma(),
//     new RajawaliNusantaraIndonesia(),
//     new GarudaIndonesia(),
//     new AngkasaPura1(),
//     new AngkasaPura2(),
//     new AsdpFerry(),
//     new JasaMarga(),
//     new KeretaApi(),
//     new Pelindo1(),
//     new Pelindo2(),
//     new Pelindo3(),
//     new Pelindo4(),
//     new Pelni(),
//     new Bulog(),
//     new BhandaGhara(),
//     new PosIndonesia(),
//     new BankBNI(),
//     new BankMandiri(),
//     new BankBRI(),
//     new BankBTN(),
//     new PNM(),
//     new Pengadaian(),
//     new AsuransiKredit(),
//     new Jamkrindo(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("PEN"),
//         backgroundColor: color_background,
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         child: ListView.builder(
//           itemCount: nama_bumn.length,
//           itemBuilder: (context, index) {
//             return Container(
//               margin: EdgeInsets.only(bottom: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     spreadRadius: 1,
//                     blurRadius: 3,
//                     color: Colors.grey.withOpacity(0.5),
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Material(
//                 borderRadius: BorderRadius.circular(5),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return _listPage[index];
//                         },
//                       ),
//                     );
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                     child: Row(
//                       children: [
//                         Text("${index + 1} "),
//                         Text("${nama_bumn[index]}"),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
