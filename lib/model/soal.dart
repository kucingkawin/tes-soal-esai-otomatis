class Soal
{
  String soal;
  double bobot;
  String jawaban;
  String jawabanBenar;
  double bobotHasil;

  Soal({this.soal, this.jawaban = "", this.jawabanBenar = "", this.bobot, this.bobotHasil = 0});
}

List<Soal> generateSampelSoal() {
  return <Soal>[
    Soal(
      soal: "Sebutkan 3 macam hewan berdasarkan apa yang dimakan!",
      jawabanBenar: "Karnivora, herbivora, dan omnivora",
      bobot: 10.0
    ),
    Soal(
      soal: "Apa fungsi dari hidung?",
      jawabanBenar: "Sebagai alat untuk pernafasan.",
      bobot: 10.0
    ),
    Soal(
      soal: "Apa yang dimaksud dengan proses bernafas?",
      jawabanBenar: "Proses menghirup oksigen dan mengeluarkan karbondioksida.",
      bobot: 10.0
    ),
    Soal(
      soal: "Jelaskan apa yang anda ketahui tentang pentingnya menjaga ikatan toleransi beragama?",
      jawabanBenar: "Negara kita terdiri dari berbagai suku, agama, dan ras. Negara kita memiliki berbagai macam keanekaragaman. Dengan menjaga ikatan, kita dapat berinteraksi antar sesama manusia tanpa adanya gangguan.",
      bobot: 10.0
    ),
    Soal(
      soal: "Mengapa tumbuhan hijau disebut dengan produsen?",
      jawabanBenar: "Semua tumbuhan hijau adalah produsen karena proses perubahan zat anorganik menjadi zat organik disebabkan adanya klorofil pada tumbuhan hijau melalui proses fotosintesis.",
      bobot: 10.0
    ),
  ];
}