import 'package:flutter/material.dart';
import 'package:tessoal/model/rabin_karp.dart';
import 'package:tessoal/part/hasil_soal_part.dart';
import 'package:tessoal/part/nomor_soal_part.dart';
import 'package:tessoal/part/soal_part.dart';

import 'model/soal.dart';

class TesPage extends StatefulWidget
{
  TesPage({Key key}) : super(key: key);

  @override
  TesPageState createState() {
    return TesPageState();
  }
}

class TesPageState extends State<TesPage>
{
  int indeksHalaman;
  List<Soal> daftarSoal;
  int indeksSoalSekarang;
  TextEditingController controllerJawaban = TextEditingController();
  double nilaiAkhir;

  TesPageState() {
    inisialisasi();
  }

  void inisialisasi()
  {
    indeksHalaman = 0;
    indeksSoalSekarang = 0;
    nilaiAkhir = 0;
    daftarSoal = generateSampelSoal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tes Soal'),
      ),
      body: IndexedStack(
        index: indeksHalaman,
        children: <Widget>[
          SoalPart(tesPageState: this),
          NomorSoalPart(tesPageState: this),
          HasilSoalPart(tesPageState: this)
        ]
      )
    );
  }

  void koreksiSoal()
  {
    double totalBobotKeseluruhan = 0;
    double totalBobotDiperoleh = 0;
    for(int i = 0; i < daftarSoal.length; i++)
    {
      RabinKarp.koreksiSoal(daftarSoal[i]);
      totalBobotDiperoleh += daftarSoal[i].bobotHasil;
      totalBobotKeseluruhan += daftarSoal[i].bobot;
    }

    nilaiAkhir = 100 * totalBobotDiperoleh / totalBobotKeseluruhan;
  }
}