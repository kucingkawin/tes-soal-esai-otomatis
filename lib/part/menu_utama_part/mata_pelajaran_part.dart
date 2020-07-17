import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tessoal/model/pelajaran.dart';
import '../../menu_utama.dart';

class MataPelajaranPart extends StatefulWidget
{
  MataPelajaranPart({Key key, this.menuUtamaPageState}) : super(key: key);

  final MenuUtamaPageState menuUtamaPageState;

  @override
  MataPelajaranPartState createState() {
    return MataPelajaranPartState();
  }
}

class MataPelajaranPartState extends State<MataPelajaranPart> {

  int indeksHalaman;

  MataPelajaranPartState() {
    indeksHalaman = 0;
  }

  Widget cardDaftarPelajaran(String nomor, MataPelajaran mataPelajaran) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Material(
          child: InkWell(
            onTap: () {
              widget.menuUtamaPageState.setState(() {
                widget.menuUtamaPageState.mataPelajaranDipilih = mataPelajaran;
                widget.menuUtamaPageState.indeksHalaman += 1;
              });
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
                              "${mataPelajaran.nama}",
                              style: TextStyle(
                                fontSize: 17.0
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text("${mataPelajaran.deskripsi}"),
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
    List<MataPelajaran> daftarMataPelajaran = widget.menuUtamaPageState.dummyData.daftarMataPelajaran;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.grey[200],
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Fransiskus Xaverius Ananda Tri Prasetio",
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
              Text("Nomor Absen: 12")
            ]
          )
        ),
        Expanded(
          child: ListView.builder(
            controller: ScrollController(),
            scrollDirection: Axis.vertical,
            itemCount: daftarMataPelajaran.length,
            itemBuilder: (context, indeks) {
              return cardDaftarPelajaran((indeks + 1).toString(), daftarMataPelajaran[indeks]);
            },
          )
        )
      ]
    );
  }
}