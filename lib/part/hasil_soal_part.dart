
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tessoal/model/soal.dart';

import '../custom_button.dart';
import '../tes.dart';

class HasilSoalPart extends StatefulWidget
{
  HasilSoalPart({Key key, this.tesPageState}) : super(key: key);

  final TesPageState tesPageState;

  @override
  HasilSoalPartState createState() {
    return HasilSoalPartState();
  }
}

class HasilSoalPartState extends State<HasilSoalPart> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Berikut ini merupakan hasil tesnya."),
                SizedBox(height: 10.0),
                Text(
                  widget.tesPageState.nilaiAkhir.toString(),
                  style: TextStyle(
                    fontSize: 30.0
                  ),
                ),
              ]
            )
          ),
          SizedBox(height: 10.0),
          Center(
            child: SizedBox(
              width: 70.0,
              height: 30.0,
              child: CustomButton.tombolMaterial(
                warna: Colors.grey[600],
                warnaTeks: Colors.white,
                teks: "Ulangi",
                onTap: (){
                  widget.tesPageState.setState((){
                    widget.tesPageState.inisialisasi();
                  });
                }
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Text(
              'Pembahasan Soal',
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Builder(
            builder: (context) {
              List<Soal> daftarSoal = widget.tesPageState.daftarSoal;
              List<Widget> cardView = List<Widget>();
              for(int i = 0; i < daftarSoal.length; i++)
              {
                Soal soal = daftarSoal[i];
                cardView.add(
                  SizedBox(
                    width: double.infinity,
                    child: Card(
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
                                  "${i + 1}.",
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
                                        soal.soal,
                                        style: TextStyle(
                                          fontSize: 17.0
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text("Jawaban",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      Text(soal.jawaban.trim().isEmpty ? "(Tidak Dijawab)" : soal.jawaban),
                                      SizedBox(height: 13.0),
                                      Text("Jawaban Benar",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      Text(soal.jawabanBenar),
                                      SizedBox(height: 13.0),
                                      Text("Bobot Nilai",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      Text("${soal.bobotHasil} dari ${soal.bobot}")
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
                );
              }

              return Column(
                children: cardView
              );
            },
          )
        ]
      )
    );
  }
}