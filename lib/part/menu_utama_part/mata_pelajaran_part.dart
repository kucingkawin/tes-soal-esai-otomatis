import 'package:backendless_sdk/backendless_sdk.dart';
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

  Future<BackendlessUser> backendlessUser;
  String emailUser, namaUser;

  @override
  void initState() {
    // Tidak ada
    namaUser = "(Belum ada)";
    backendlessUser = Backendless.userService.currentUser();
    backendlessUser.then((value) {
      setState((){
        emailUser = value.email;
      });
    });
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
                widget.menuUtamaPageState.loadChapter(mataPelajaran);
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
    return FutureBuilder(
      future: widget.menuUtamaPageState.futureDaftarMataPelajaran,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Lagi loading ya...")
          );
        } else if (snapshot.connectionState == ConnectionState.done){
          return widgetMataPelajaran(snapshot.data);
        } else {
          return Container();
        }
      },
    );
  }

  Widget widgetMataPelajaran(List<MataPelajaran> daftarMataPelajaran) {
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
                "$emailUser",
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
              Text("Selamat datang di tes soal.")
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