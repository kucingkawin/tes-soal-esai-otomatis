import 'package:flutter/services.dart';

class Kamus {

  List<String> dataKamus;
  String direktori = "";

  Future<Kamus> baca(String direktori) async {
    String data = await rootBundle.loadString(direktori);
    String sementara = "";
    List<String> dataKamusBaru = List<String>();
    int langkah = 0;
    for(int i = 0; i < data.length; i++) {
      bool melewatiTandaBaris = (data[i] == "\r" || data[i] == "\n");
      if (langkah == 0) {
        if (melewatiTandaBaris) {
          _tambahData(dataKamusBaru, sementara);
          sementara = "";
          langkah = 1;
        }
        else {
          sementara += data[i];
          if (i == data.length - 1) {
            _tambahData(dataKamusBaru, sementara);
          }
        }
      } else if (langkah == 1) {
        if (!melewatiTandaBaris) {
          sementara += data[i];
          langkah = 0;
        }
      }
    }

    dataKamus = dataKamusBaru;
    return this;
  }

  void _tambahData(List<String> dataKamusBaru, String sementara) {
    dataKamusBaru.add(sementara);
  }
}