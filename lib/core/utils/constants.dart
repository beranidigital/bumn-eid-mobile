import 'dart:ui';

import 'package:bumn_eid/core/models/business_portfolio/grafik_jenis_perusahaan.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Constants {
  static final apiKeyHeader = "API-KEY";
  static final contentTypeHeader = "Content-type";
  static final acceptHeader = "Accept";
  static final authorizationHeader = "Authorization";

  static final DUMMY_EMAIL = "admin@bumn.go.id";
  static final DUMMY_PASSWORD = "password";

  static final latestDataYear = "2019";
  static final maxSavedDataInHrs = 72;

  static final direkturType = "1";
  static final komisarisType = "2";

  static final randomColorList = [
    const Color(0xff00BDCC),
    const Color(0xff5AB7A5),
    const Color(0xff98CFA4),
    const Color(0xffD4E3AC),
    const Color(0xffDFC276),
    const Color(0xffF19857),
    const Color(0xffFD625E),
    const Color(0xff8D9AA9),
  ];

  static final smallDeviceHeight = 570.0;

  static final akunKontribusiNegara = ["pajak", "dividen", "pnbp"];

  static final tahunList = [2018, 2019, 2020];

  static int million = 1000000;

  static int billion = 1000000000;

  static int trillion = 1000000000000;

  static double tableFontSize = 14.0;

  // static String apiKey =
  //     "\$2y\$10\$7RGoihzeUY9NBnpZvKJYM.cPXiLfLwqvCka.2pbv6FM2yzpED5LH2";

  static String apiKey =
      "\$2y\$10\$qhQoh2xJbwMuZiZCBmCf5uMgkE4AItNqd8YDZ5T5JoZ0gswprzAHG";

  static final indonesiaCameraPosition = CameraPosition(
    target: LatLng(-2.0999428, 118.2893937),
    zoom: 3.2046,
  );

  static final indonesiaCameraPositionMarker = LatLng(-2.0999428, 118.2893937);

  static final wamenList = ["-", "WAMEN I", "WAMEN II"];

  static final dummyJenisData = {
    "Persero": [
      GrafikJenisPerusahaan(jenis_bumn: "Persero", jumlah: 84, tahun: "2017"),
      GrafikJenisPerusahaan(jenis_bumn: "Persero", jumlah: 84, tahun: "2018"),
      GrafikJenisPerusahaan(jenis_bumn: "Persero", jumlah: 84, tahun: "2019"),
    ],
    "Minoritas": [
      GrafikJenisPerusahaan(jenis_bumn: "Minoritas", jumlah: 20, tahun: "2017"),
      GrafikJenisPerusahaan(jenis_bumn: "Minoritas", jumlah: 20, tahun: "2018"),
      GrafikJenisPerusahaan(jenis_bumn: "Minoritas", jumlah: 20, tahun: "2019"),
    ],
    "Perum": [
      GrafikJenisPerusahaan(jenis_bumn: "Perum", jumlah: 10, tahun: "2017"),
      GrafikJenisPerusahaan(jenis_bumn: "Perum", jumlah: 10, tahun: "2018"),
      GrafikJenisPerusahaan(jenis_bumn: "Perum", jumlah: 10, tahun: "2019"),
    ],
    "Persero\ntbk": [
      GrafikJenisPerusahaan(
          jenis_bumn: "Persero\ntbk", jumlah: 15, tahun: "2017"),
      GrafikJenisPerusahaan(
          jenis_bumn: "Persero\ntbk", jumlah: 15, tahun: "2018"),
      GrafikJenisPerusahaan(
          jenis_bumn: "Persero\ntbk", jumlah: 15, tahun: "2019"),
    ],
  };

  static final dummyJenisKeyToColor = {
    "2017": Color(0xFFFE8282),
    "2018": Color(0xFFFBD300),
    "2019": Color(0xFF4572E5),
  };

  static final debugMode = false;

  static final mapToLat = {
    'JAKARTA': LatLng(-6.2293867, 106.6894316),
    'KAB. MANOKWARI': LatLng(-0.8642815, 134.0390789),
    'KAB. PURWAKARTA': LatLng(-6.5920369, 107.2711876),
    'KAB. PURWOREJO': LatLng(-7.7076465, 109.8298781),
    'KAB. SUBANG': LatLng(-6.4945322, 107.4543848),
    'KOTA BANDUNG': LatLng(-6.9032739, 107.5731171),
    'KOTA BANJARBARU': LatLng(-3.4591478, 114.7301841),
    'KOTA MADIUN': LatLng(-7.6299754, 111.4930318),
    'KOTA MANADO': LatLng(1.540986, 124.714446),
    'KOTA MEDAN': LatLng(3.6426183, 98.5294069),
    'KOTA PASURUAN': LatLng(-7.6513924, 112.8875852),
    'KOTA SURABAYA': LatLng(-7.2754438, 112.6426433),
    'KOTA TANGERANG ': LatLng(-6.1765123, 106.5799935),
  };

  static final bulanList = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
}
