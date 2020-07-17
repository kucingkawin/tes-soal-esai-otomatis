import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tessoal/model/pelajaran.dart';
import '../../menu_utama.dart';
import '../../tes.dart';

class ChapterPart extends StatefulWidget
{
  ChapterPart({Key key, this.menuUtamaPageState}) : super(key: key);

  final MenuUtamaPageState menuUtamaPageState;

  @override
  ChapterPartState createState() {
    return ChapterPartState();
  }
}

class ChapterPartState extends State<ChapterPart> {

  int indeksHalaman;

  ChapterPartState() {
    indeksHalaman = 0;
  }

  Widget cardChapter(String nomor, Chapter chapter) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Material(
          child: InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(TesPage.route);
            },
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "$nomor.",
                        style: TextStyle(
                          fontSize: 17.0
                        )
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${chapter.nama}",
                              style: TextStyle(
                                fontSize: 17.0
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text("${chapter.deskripsi}"),
                          ]
                        )
                      )
                    ],
                  ),
                ],
              )
            ),
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    MataPelajaran mataPelajaranDipilih = widget.menuUtamaPageState.mataPelajaranDipilih;
    List<Chapter> daftarChapter = widget.menuUtamaPageState.dummyData.daftarChapter;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.grey[200],
          padding: EdgeInsets.all(16.0),
          child: Builder(
            builder: (context) {
              List<Widget> daftarKolom = List<Widget>();
              if (mataPelajaranDipilih != null) {
                daftarKolom.addAll(<Widget>[
                  Text(
                    "${mataPelajaranDipilih.nama}",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  Text("${mataPelajaranDipilih.deskripsi}")
                ]);
              } else {
                daftarKolom.add(Text(
                  "Tidak ada yang ditampilkan",
                  style: TextStyle(
                      fontSize: 20.0
                  ),
                ));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: daftarKolom
              );
            }
          )
        ),
        Expanded(
          child: ListView.builder(
            controller: ScrollController(),
            scrollDirection: Axis.vertical,
            itemCount: daftarChapter.length,
            itemBuilder: (context, indeks) {
              return cardChapter((indeks + 1).toString(), daftarChapter[indeks]);
            },
          )
        )
      ]
    );
  }
}