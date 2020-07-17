import 'package:tessoal/model/pelajaran.dart';
import 'package:tessoal/model/stemming/stemmer/stemmer.dart';

class RabinKarp
{
  static void koreksiSoal(Soal soal, Stemmer stemmer)
  {
    print("");

    //Tahap tokenizing jawaban.
    List<String> tokenJawaban = _tahapTokenizing(soal.jawaban);
    print("Token jawaban: ${tokenJawaban}");

    //Tahap stemming jawaban
    _tahapStemming(tokenJawaban, stemmer);
    print("Token jawaban stemming: ${tokenJawaban}");

    //Persentase kesamaan terbesar
    List<Object> persentaseKesamaanTerbesar = <Object>[
      0, 0.0
    ];

    for(int i = 0; i < soal.kunciJawaban.length; i++) {
      KunciJawaban kunciJawaban = soal.kunciJawaban[i];

      //Tahap tokenizing jawaban benar.
      List<String> tokenJawabanBenar = _tahapTokenizing(kunciJawaban.jawabanBenar);
      print("Token jawaban benar: ${tokenJawabanBenar}");

      //Tahap jawaban benar, dan kata kunci
      _tahapStemming(tokenJawabanBenar, stemmer);
      _tahapStemming(kunciJawaban.kataKunci, stemmer);
      print("Token jawaban benar stemming: ${tokenJawabanBenar}");
      print("Token kata kunci stemming: ${kunciJawaban.kataKunci}");

      //Tahap filtering jawaban dan kunci jawaban berdasarkan kata kunci
      List<String> tokenJawabanFilter = _tahapFiltering(tokenJawaban, kunciJawaban.kataKunci);
      List<String> tokenJawabanBenarFilter = _tahapFiltering(tokenJawabanBenar, kunciJawaban.kataKunci);
      print("Token jawaban filter: ${tokenJawabanFilter}");
      print("Token jawaban benar filter: ${tokenJawabanBenarFilter}");

      //Tahap penyatuan token
      String modifiedJawaban = _tokenKeString(tokenJawabanFilter);
      String modifiedJawabanBenar = _tokenKeString(tokenJawabanBenarFilter);
      print("Modified jawaban: ${modifiedJawaban}");
      print("Modified jawaban benar: ${modifiedJawabanBenar}");

      //Parse k-gram 4, kemudian diubah langsung ke hash
      List<int> hashJawaban = _parseKgramHash(modifiedJawaban, soal.kGram);
      List<int> hashJawabanBenar = _parseKgramHash(modifiedJawabanBenar, soal.kGram);
      print("Hash jawaban: ${hashJawaban}");
      print("Hash jawaban benar: ${hashJawabanBenar}");

      //Fingerprint hash
      List<int> fingerprintHashJawaban = _fingerprintHash(hashJawaban);
      List<int> fingerprintHashJawabanBenar = _fingerprintHash(hashJawabanBenar);
      print("Fingerprint jawaban: ${fingerprintHashJawaban}");
      print("Fingerprint jawaban benar: ${fingerprintHashJawabanBenar}");

      //Komparasi hash
      List<int> hashSama = _komparasiHash(fingerprintHashJawaban, fingerprintHashJawabanBenar);
      print("Hash Sama: ${hashSama}");

      //Persentase kesamaan
      double persentaseKesamaan = 100 * ((2 * hashSama.length) / (fingerprintHashJawaban.length + fingerprintHashJawabanBenar.length));
      print("Persentase Kesamaan: $persentaseKesamaan");
      if (persentaseKesamaan > persentaseKesamaanTerbesar[1]) {
        persentaseKesamaanTerbesar[1] = persentaseKesamaan;
        persentaseKesamaanTerbesar[0] = i;
      }

      print("------");
    }

    soal.bobotHasil = soal.bobot * persentaseKesamaanTerbesar[1] / 100;
    print("Bobot hasil: ${soal.bobotHasil}");
  }

  static List<String> _tahapTokenizing(String teks)
  {
    List<String> hasil = List<String>();
    int langkah = 1;
    String sementara = "";
    for(int i = 0; i < teks.length; i++)
    {
      bool tambahKata = false;
      String huruf = teks[i].toLowerCase();
      if(langkah == 1)
      {
        if(_cekAdalahHuruf(huruf))
        {
          sementara += huruf;
          if(i == teks.length - 1)
            tambahKata = true;
        }
        else
        {
          tambahKata = true;
          langkah = 2;
        }
      }
      else if(langkah == 2)
      {
        if(_cekAdalahHuruf(huruf))
        {
          sementara += huruf;
          langkah = 1;

          if(i == teks.length - 1)
            tambahKata = true;
        }
      }

      if(tambahKata)
      {
        hasil.add(sementara);
        sementara = "";
      }
    }

    return hasil;
  }

  static void _tahapStemming(List<String> token, Stemmer stemmer) {
    for(int i = 0; i < token.length; i++) {
      String tokenLowercase = token[i].toLowerCase();
      token[i] = stemmer.getRootWord2(tokenLowercase, tokenLowercase);
    }
  }

  static List<String> _tahapFiltering(List<String> token, List<String> kataKunci) {
    List<String> hasil = List<String>();
    for (int i = 0; i < token.length; i++) {
      for (int j = 0; j < kataKunci.length; j++) {
        if (token[i] == kataKunci[j]) {
          if (hasil.length > 0) {
            for (int k = 0; k < hasil.length; k++) {
              if (token[i] == hasil[k]) {
                break;
              } else if (k == hasil.length - 1) {
                hasil.add(token[i]);
              }
            }
          } else {
            hasil.add(token[i]);
          }
        }
      }
    }

    return hasil;
  }

  static String _tokenKeString(List<String> token)
  {
    String hasil = "";
    for(int i = 0; i < token.length; i++)
      hasil += token[i];

    return hasil;
  }

  static List<int> _parseKgramHash(String kalimat, int kgram)
  {
    List<int> hasil = List<int>();
    int iKe = 0;
    int jKe = iKe;
    int jTargetKe = jKe + (kgram - 1);
    String sementara = "";

    while(iKe <= kalimat.length - 1)
    {
      jKe = iKe;
      while(jKe <= jTargetKe)
      {
        sementara += kalimat[jKe];
        jKe += 1;
      }

      hasil.add(sementara.hashCode);
      sementara = "";

      iKe += 1;
      jKe = iKe;
      jTargetKe = jKe + (kgram - 1);
      if(jTargetKe > kalimat.length - 1)
        break;
    }

    return hasil;
  }

  static List<int> _fingerprintHash(List<int> hash) {
    List<int> hasil = List<int>();
    for(int i = 0; i < hash.length; i++)
    {
      if(hasil.length == 0)
        hasil.add(hash[i]);
      else
      {
        for(int j = 0; j < hasil.length; j++)
        {
          if(hash[i] == hasil[j])
            break;
          else if(j == hasil.length - 1)
            hasil.add(hash[i]);
        }
      }
    }

    return hasil;
  }


  static List<int> _komparasiHash(List<int> hash1, List<int> hash2)
  {
    List<int> hasil = List<int>();
    for(int i = 0; i < hash1.length; i++)
    {
      for(int j = 0; j < hash2.length; j++)
      {
        if(hash1[i] == hash2[j])
        {
          hasil.add(hash1[i]);
          break;
        }
      }
    }

    return hasil;
  }

  static bool _cekAdalahHuruf(String huruf) {
    if(huruf.length > 1)
      return false;

    int ascii = huruf.codeUnitAt(0);
    if(ascii >= 97 && ascii <= 122)
      return true;

    return false;
  }
}