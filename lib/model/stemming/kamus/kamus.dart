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
      bool melewatiTandaBaris = data[i] == "\r" || data[i] == "\n";
      if (langkah == 0) {
        sementara += data[i];
        if (melewatiTandaBaris || i == data.length - 1) {
          dataKamusBaru.add(sementara);
          sementara = "";
          langkah = 1;
        }
      } else if (langkah == 1) {
        if (!melewatiTandaBaris) {
          langkah = 0;
        }
      }
    }

    dataKamus = dataKamusBaru;
    return this;
  }
}