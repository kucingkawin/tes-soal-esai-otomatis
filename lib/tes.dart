import 'package:flutter/material.dart';
import 'package:tessoal/model/rabin_karp.dart';
import 'package:tessoal/model/pelajaran.dart';
import 'package:tessoal/part/tes_part/hasil_soal_part.dart';
import 'package:tessoal/part/tes_part/nomor_soal_part.dart';
import 'package:tessoal/part/tes_part/soal_part.dart';
import 'model/stemming/kamus/kamus.dart';
import 'model/stemming/stemmer/stemmer.dart';

class TesPage extends StatefulWidget
{
  static String route = "tes";

  final Chapter chapter;

  TesPage({Key key, this.chapter}) : super(key: key);

  @override
  TesPageState createState() {
    return TesPageState();
  }
}

class TesPageState extends State<TesPage>
{
  int indeksHalaman;
  Future<List<Soal>> _futureDaftarSoal;
  List<Soal> daftarSoal;
  int indeksSoalSekarang;
  TextEditingController controllerJawaban = TextEditingController();
  DummyData dummyData;
  double nilaiAkhir;

  @override
  void initState() {
    inisialisasi();
  }

  void inisialisasi()
  {
    indeksHalaman = 0;
    indeksSoalSekarang = 0;
    nilaiAkhir = 0;
    dummyData = DummyData();
    _futureDaftarSoal = Soal.loadSoal(widget.chapter);
    //daftarSoal = dummyData.daftarSoal;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureDaftarSoal,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Text("Lagi loading ya...")
            )
          );
        } else if (snapshot.connectionState == ConnectionState.done){
          daftarSoal = snapshot.data; //dummyData.daftarSoal;
          return _widgetTest();
        } else {
          return Container();
        }
      }
    );
  }

  Widget _widgetTest() {
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

  Future<void> koreksiSoal() async
  {
    //Stemmer
    Kamus kamus = await Kamus().baca("assets/kamus.txt");
    Stemmer stemmer = Stemmer(kamus.dataKamus);

    double totalBobotKeseluruhan = 0;
    double totalBobotDiperoleh = 0;
    for(int i = 0; i < daftarSoal.length; i++)
    {
      RabinKarp.koreksiSoal(daftarSoal[i], stemmer);
      totalBobotDiperoleh += daftarSoal[i].bobotHasil;
      totalBobotKeseluruhan += daftarSoal[i].bobot;
    }

    nilaiAkhir = 100 * totalBobotDiperoleh / totalBobotKeseluruhan;
  }
}