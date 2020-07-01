import 'package:tessoal/model/soal.dart';

class RabinKarp
{
  static final List<String> daftarKataPenghubung = <String>[
    'adalah', 'ialah', 'dan', 'atau', 'serta', 'bahwa', 'bahwasannya', 'meliputi'
  ];

  static void koreksiSoal(Soal soal)
  {
    //Tahap tokenizing
    List<String> tokenJawaban = _tahapTokenizing(soal.jawaban);
    List<String> tokenJawabanBenar = _tahapTokenizing(soal.jawabanBenar);
    print("Token jawaban: ${tokenJawaban}");
    print("Token jawaban benar: ${tokenJawabanBenar}");

    //Tahap penyatuan token
    String modifiedJawaban = _tokenKeString(tokenJawaban);
    String modifiedJawabanBenar = _tokenKeString(tokenJawabanBenar);
    print("Modified jawaban: ${modifiedJawaban}");
    print("Modified jawaban benar: ${modifiedJawabanBenar}");

    //Parse k-gram 4, kemudian diubah langsung ke hash
    List<int> hashJawaban = _parseKgramHash(modifiedJawaban, 4);
    List<int> hashJawabanBenar = _parseKgramHash(modifiedJawabanBenar, 4);
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

    //Penghitungan bobot
    soal.bobotHasil = soal.bobot * ((2 * hashSama.length) / (fingerprintHashJawaban.length + fingerprintHashJawabanBenar.length));
    print("Bobot hasil: ${soal.bobotHasil}");
  }

  static List<String> _tahapTokenizing(String soal)
  {
    List<String> hasil = List<String>();
    int langkah = 1;
    String sementara = "";
    for(int i = 0; i < soal.length; i++)
    {
      bool tambahKata = false;
      String huruf = soal[i].toLowerCase();
      if(langkah == 1)
      {
        if(_cekAdalahHuruf(huruf))
        {
          sementara += huruf;
          if(i == soal.length - 1)
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

          if(i == soal.length - 1)
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