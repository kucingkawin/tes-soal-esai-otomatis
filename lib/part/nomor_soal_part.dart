import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/soal.dart';
import '../custom_button.dart';
import '../tes.dart';

class NomorSoalPart extends StatefulWidget
{
  NomorSoalPart({Key key, this.tesPageState}) : super(key: key);

  final TesPageState tesPageState;

  @override
  NomorSoalPartState createState() {
    return NomorSoalPartState();
  }
}

class NomorSoalPartState extends State<NomorSoalPart>
{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    legendNomorSoal(Colors.red, "Belum dijawab."),
                    SizedBox(height: 10.0),
                    legendNomorSoal(Colors.green, "Sudah dijawab."),
                  ]
                ),
              ),
              SizedBox(
                width: 70.0,
                height: 30.0,
                child: CustomButton.tombolMaterial(
                  warna: Colors.grey,
                  warnaTeks: Colors.white,
                  teks: "Selesai",
                  onTap: (){
                    TesPageState state = widget.tesPageState;
                    state.koreksiSoal();
                    state.setState((){
                      state.indeksHalaman += 1;
                    });
                  }
                ),
              )
            ]
          )
        ),
        Expanded(
          child: Builder(
            builder: (context){
              List<Widget> hasil = List<Widget>();
              List<Soal> daftarSoal = widget.tesPageState.daftarSoal;
              for(int i = 0; i < daftarSoal.length; i++)
              {
                Soal soal = daftarSoal[i];
                Color warna = Colors.red;
                if(soal.jawaban != null)
                {
                  if(soal.jawaban.trim().isNotEmpty)
                    warna = Colors.green;
                }

                hasil.add(
                  SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CustomButton.tombolMaterial(
                      warna: warna,
                      warnaTeks: Colors.white,
                      teks: "${i + 1}",
                      border: i == widget.tesPageState.indeksSoalSekarang,
                      fontWeight: i == widget.tesPageState.indeksSoalSekarang ? FontWeight.bold : FontWeight.normal,
                      onTap: (){
                        TesPageState state = widget.tesPageState;
                        state.setState((){
                          state.indeksSoalSekarang = i;
                          state.indeksHalaman -= 1;
                          state.controllerJawaban.text = state.daftarSoal[state.indeksSoalSekarang].jawaban;
                        });
                      },
                    )
                  )
                );
              }

              return Padding(
                padding: EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0, bottom: 16.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: hasil,
                  spacing: 10.0,
                  runSpacing: 10.0
                )
              );
            },
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
                  teks: "Soal",
                  onTap: (){
                    TesPageState state = widget.tesPageState;
                    state.setState((){
                      state.indeksHalaman -= 1;
                    });
                  }
                ),
              ),
            ]
          )
        )
      ]
    );
  }

  Widget legendNomorSoal(Color warna, String nama)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          color: warna,
          width: 20.0,
          height: 20.0
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(nama)
        )
      ],
    );
  }
}