import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tessoal/model/soal.dart';

import '../custom_button.dart';
import '../tes.dart';

class SoalPart extends StatefulWidget
{
  SoalPart({Key key, this.tesPageState}) : super(key: key);

  final TesPageState tesPageState;

  @override
  SoalPartState createState() {
    return SoalPartState();
  }
}

class SoalPartState extends State<SoalPart>
{
  @override
  Widget build(BuildContext context) {
    TesPageState state = widget.tesPageState;
    Soal soal = state.daftarSoal[state.indeksSoalSekarang];
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Jawablah soal esai ini sesuai dengan kemampuanmu.'),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${state.indeksSoalSekarang + 1}'),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('${soal.soal}'),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "Silakan jawab soal tersebut.",
                                ),
                                controller: state.controllerJawaban,
                                onChanged: (teks) {
                                  TesPageState state = widget.tesPageState;
                                  state.setState((){
                                    state.daftarSoal[state.indeksSoalSekarang].jawaban = teks;
                                  });
                                },
                                maxLines: null,
                              )
                            ]
                          )
                        )
                      ]
                    )
                  ]
                )
              ],
            ),
          )
        ),
        SizedBox(
          width: double.infinity,
          height: 40.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: CustomButton.tombolMaterial(
                  warna: Colors.grey[600],
                  warnaTeks: Colors.white,
                  teks: "Sebelumnya",
                  onTap: _sebelumnya
                ),
              ),
              Expanded(
                child: CustomButton.tombolMaterial(
                  warna: Colors.green,
                  warnaTeks: Colors.white,
                  teks: "Cek Soal",
                  onTap: _cekSoal
                ),
              ),
              Expanded(
                child: CustomButton.tombolMaterial(
                  warna: Colors.grey[600],
                  warnaTeks: Colors.white,
                  teks: "Berikutnya",
                  onTap: _berikutnya
                ),
              )
            ]
          )
        )
      ]
    );
  }

  void _berikutnya()
  {
    TesPageState state = widget.tesPageState;
    state.setState((){
      int indeksMaksimal = state.daftarSoal.length - 1;
      state.indeksSoalSekarang += 1;
      if(state.indeksSoalSekarang > indeksMaksimal)
        state.indeksSoalSekarang = indeksMaksimal;

      state.controllerJawaban.text = state.daftarSoal[state.indeksSoalSekarang].jawaban;
    });
  }

  void _sebelumnya()
  {
    TesPageState state = widget.tesPageState;
    state.setState((){
      state.indeksSoalSekarang -= 1;
      if(state.indeksSoalSekarang < 0)
        state.indeksSoalSekarang = 0;

      state.controllerJawaban.text = state.daftarSoal[state.indeksSoalSekarang].jawaban;
    });
  }

  void _cekSoal()
  {
    TesPageState state = widget.tesPageState;
    state.setState((){
      state.indeksHalaman += 1;
      if(!FocusScope.of(context).hasPrimaryFocus)
        FocusScope.of(context).unfocus();

      state.controllerJawaban.text = state.daftarSoal[state.indeksSoalSekarang].jawaban;
    });
  }
}