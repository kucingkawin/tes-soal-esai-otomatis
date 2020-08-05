import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tessoal/part/menu_utama_part/chapter_part.dart';
import 'package:tessoal/part/menu_utama_part/mata_pelajaran_part.dart';
import 'model/pelajaran.dart';

class MenuUtamaPage extends StatefulWidget
{
  static String route = "menu-utama";

  MenuUtamaPage({Key key}) : super(key: key);

  @override
  MenuUtamaPageState createState() {
    return MenuUtamaPageState();
  }
}

class MenuUtamaPageState extends State<MenuUtamaPage>
{
  DummyData dummyData;
  MataPelajaran mataPelajaranDipilih;
  Chapter chapterDipilih;
  int indeksHalaman;

  Future<List<MataPelajaran>> futureDaftarMataPelajaran;
  Future<List<Chapter>> futureDaftarChapter;

  @override
  void initState() {
    dummyData = DummyData();
    mataPelajaranDipilih = null;
    chapterDipilih = null;
    indeksHalaman = 0;
    loadMataPelajaran();
  }

  void loadMataPelajaran() {
    futureDaftarMataPelajaran = MataPelajaran.loadMataPelajaran();
  }

  void loadChapter(MataPelajaran mataPelajaran) {
    futureDaftarChapter = Chapter.loadChapter(mataPelajaran);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (indeksHalaman == 0)
          return true;

        setState(() {
          indeksHalaman -= 1;
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Builder(
            builder: (context) {
              String teks = "Menu Utama";
              if (indeksHalaman == 1)
                teks = "Menu Utama > Bab";

              return Text(teks);
            },
          ),
        ),
        body: IndexedStack(
          index: indeksHalaman,
          children: <Widget>[
            MataPelajaranPart(menuUtamaPageState: this),
            ChapterPart(menuUtamaPageState: this)
          ]
        )
      )
    );
  }
}