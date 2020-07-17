class MataPelajaran {
  String id;
  String nama;
  String deskripsi;

  MataPelajaran({this.id, this.nama, this.deskripsi});
}

class Chapter {
  String id;
  MataPelajaran mataPelajaran;
  String nama;
  String deskripsi;

  Chapter({this.id, this.mataPelajaran, this.nama, this.deskripsi});
}

class KunciJawaban {
  String jawabanBenar;
  List<String> kataKunci;

  KunciJawaban({this.jawabanBenar, this.kataKunci});
}

class Soal
{
  Chapter chapter;
  String soal;
  double bobot;
  String jawaban;
  List<KunciJawaban> kunciJawaban;
  int kGram;
  double bobotHasil;

  Soal({this.chapter, this.soal, this.jawaban = "", this.kunciJawaban, this.bobot, this.bobotHasil = 0, this.kGram = 4});
}

class DummyData {
  List<MataPelajaran> daftarMataPelajaran;
  List<Chapter> daftarChapter;
  List<Soal> daftarSoal;

  DummyData() {
    daftarMataPelajaran = <MataPelajaran>[
      MataPelajaran(
        id: "1",
        nama: "IPA",
        deskripsi: "Ilmu Pengetahuan Alam"
      ),
    ];

    daftarChapter = <Chapter>[
      Chapter(
        id: "1",
        mataPelajaran: daftarMataPelajaran[0],
        nama: "Ilmu Alam Dasar",
        deskripsi: "Ilmu yang mempelajari suatu hal yang dasar."
      ),
    ];

    daftarSoal = <Soal>[
      Soal(
        chapter: daftarChapter[0],
        soal: "Sebutkan 3 macam hewan berdasarkan apa yang dimakan!",
        kunciJawaban: <KunciJawaban>[
          KunciJawaban(
            jawabanBenar: "Karnivora, herbivora, dan omnivora",
            kataKunci: <String>["Karnivora", "Herbivora", "Omnivora"],
          )
        ],
        bobot: 10.0
      ),
      Soal(
        chapter: daftarChapter[0],
        soal: "Apa fungsi dari hidung?",
        kunciJawaban: <KunciJawaban>[
          KunciJawaban(
            jawabanBenar: "Sebagai alat untuk pernafasan",
            kataKunci: <String>["Bernafas"],
          )
        ],
        bobot: 10.0
      ),
      Soal(
        chapter: daftarChapter[0],
        soal: "Apa yang dimaksud dengan proses bernafas?",
        kGram: 1,
        kunciJawaban: <KunciJawaban>[
          KunciJawaban(
            jawabanBenar: "Proses menghirup dan mengeluarkan udara.",
            kataKunci: <String>["Menghirup", "Mengeluarkan", "Udara"],
          ),
          KunciJawaban(
            jawabanBenar: "Proses menghirup dan menghembuskan udara.",
            kataKunci: <String>["Menghirup", "Menghembuskan", "Udara"],
          ),
          KunciJawaban(
            jawabanBenar: "Proses menghirup oksigen dan mengeluarkan karbondioksida.",
            kataKunci: <String>["Menghirup", "Oksigen", "Mengeluarkan", "Karbondioksida"],
          ),
          KunciJawaban(
            jawabanBenar: "Proses menghirup oksigen dan menghembuskan karbondioksida.",
            kataKunci: <String>["Menghirup", "Oksigen", "Menghembuskan", "Karbondioksida"],
          ),
          KunciJawaban(
            jawabanBenar: "Proses menghirup udara oksigen dan menghembuskan udara karbondioksida.",
            kataKunci: <String>["Menghirup", "Udara", "Oksigen", "Menghembuskan", "Karbondioksida"],
          )
        ],
        bobot: 100.0
      ),
      Soal(
        chapter: daftarChapter[0],
        soal: "Jelaskan apa yang anda ketahui tentang pentingnya menjaga ikatan toleransi beragama?",
        kunciJawaban: <KunciJawaban>[
          KunciJawaban(
            jawabanBenar: "Negara kita terdiri dari berbagai suku, agama, dan ras. Negara kita memiliki berbagai macam keanekaragaman. Dengan menjaga ikatan, kita dapat berinteraksi antar sesama manusia tanpa adanya gangguan.",
            kataKunci: <String>["suku", "agama", "ras", "keanekaragaman", "ikatan", "interaksi", "manusia", "gangguan"],
          )
        ],
        bobot: 10.0
      ),
      Soal(
        chapter: daftarChapter[0],
        soal: "Mengapa tumbuhan hijau disebut dengan produsen?",
        kunciJawaban: <KunciJawaban>[
          KunciJawaban(
            jawabanBenar: "Semua tumbuhan hijau adalah produsen karena proses perubahan zat anorganik menjadi zat organik disebabkan adanya klorofil pada tumbuhan hijau melalui proses fotosintesis.",
            kataKunci: <String>["produsen", "anorganik", "organik", "klorofil", "ikatan", "fotosintesis"],
          )
        ],
        bobot: 10.0
      ),
    ];
  }
}

class HasilPerhitungan {
  double persentaseKesamaan;

  HasilPerhitungan({this.persentaseKesamaan});
}